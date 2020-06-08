Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF4B1F1246
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2020 06:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgFHErS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Jun 2020 00:47:18 -0400
Received: from qrelay185.mxroute.com ([172.82.139.185]:38221 "EHLO
        qrelay185.mxroute.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgFHErS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Jun 2020 00:47:18 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 00:47:17 EDT
Received: from filter004.mxroute.com ([149.28.56.236] 149.28.56.236.vultr.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by qrelay185.mxroute.com (ZoneMTA) with ESMTPA id 172923c76400008e63.001
 for <linux-wireless@vger.kernel.org>;
 Mon, 08 Jun 2020 04:42:15 +0000
X-Zone-Loop: 6a45414d7b2002c573b002412ea87c646a4f17068210
X-Originating-IP: [149.28.56.236]
Received: from eagle.mxlogin.com (unknown [23.92.74.70])
        by filter004.mxroute.com (Postfix) with ESMTPS id 83C433EA05
        for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2020 04:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=libreelec.tv; s=default; h=To:Date:Message-Id:Subject:Mime-Version:
        Content-Transfer-Encoding:Content-Type:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4K7ogQ1JELYpZUIK5m9mzpiewlz2QjWWzBfzvb1t47c=; b=GDkXbfqO6ri2gca9W0SqUAd5v7
        fdK+sWzVK4YPnB3mRLATKJ99CmmgPyBJuGoPfjg70jPV3rQmrBH2ClT3cIKJjJ6EhBG+y9RUFoWk0
        nuBLLyWcgWFI7vufGawia/PHrGr4i/IWMrN8HF0T3gQNbL7Gpg+GR2IEmlpc5GCxKF9zycJOabVYa
        DD1Ped3ZKTS4Y8mfS2UqUv2zhoZMXdl/ZjT92qpDMW1LyUuyEg2mQPbI7SDN0xhP5JqU1DU+JG4YM
        czhkgCfpNfgVk5cCCDLLuZrAcYbabyatvLpujuoDaVmq6gKMkCeQ4M4cqjBNFIRNaRgh6lMiIyUmt
        Ly6ZVqQg==;
From:   Christian Hewitt <chewitt@libreelec.tv>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: rtw88 SDIO support?
Message-Id: <50223157-F9F8-4039-87E7-A8575DF10945@libreelec.tv>
Date:   Mon, 8 Jun 2020 08:42:11 +0400
To:     Linux Wireless <linux-wireless@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.14)
X-AuthUser: chewitt@libreelec.tv
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I=E2=80=99m a maintainer for a distro that runs Kodi mediacentre on many =
popular ARM SBCs and Android STBs (replacing Android).=20

I have a number of requests for WiFi support on Amlogic SoC devices =
using RTL8822CS chips which rtw88 supports on PCI, but not SDIO.

Can I ask if there is any timeline/plan for SDIO support? .. the =
out-of-tree vendor drivers are hassle for distro=E2=80=99s to maintain.

Christian

