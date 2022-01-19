Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4A493840
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 11:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiASKTJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 05:19:09 -0500
Received: from mout.web.de ([217.72.192.78]:54051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbiASKTI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 05:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642587547;
        bh=9fB8RDDhanM84fmnD9XdwRsIHt6cmEMW9BgWtV5aa7c=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=XEQJ2IefLppiJtVMeLKkCxEoBiJAnYcL6ksyeQ8jGBmxUrxYWHirRjNS08KzrPY7v
         i8lZIAeIJQjcJb+/uMtG7b08CZ/ACzkp/8y4MO6jA5ebPAyqY9BYNgUJq7hwWDvHht
         1qjp1xEruf7BsJrfA36E78q6IsexoEwf7iq4ZaQE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [80.245.136.130] ([80.245.136.130]) by web-mail.web.de
 (3c-app-webde-bap45.server.lan [172.19.172.45]) (via HTTP); Wed, 19 Jan
 2022 11:19:07 +0100
MIME-Version: 1.0
Message-ID: <trinity-928b391a-89df-43af-8eb5-f33111bf78fc-1642587547454@3c-app-webde-bap45>
From:   fckath@web.de
To:     linux-wireless@vger.kernel.org
Subject: hostapd and Wifi6 - howto?
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 19 Jan 2022 11:19:07 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:DKVNZTuCMymzhA1BXXjoyu22kqG2BVFcNSk7eOsybtBrVm3lgrBrw0+laf5NSKoh63jAK
 fQ4iAfwiG3Uqta03aiSuHHotP/YMLJq907eOqYih8kYJXFjILfZ0vSSS7tuQSz32+jfs/+3NQV9X
 OGAJXXX71/3C5goLS+UdKmCXxz3U6QrGy3FbzTpu4bNDACwwMq2du2iCzkOrTJB8GZOKJlzxKd7s
 ntZ+/XXiILOq1DFthSVP6npc4qLtTvwkpFNZ/9cG7usCVWwMY3huluC/O3P2lu5h1T2WnSQvCBOe
 pc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CYjPmyUJKco=:8GVEOdx2pRfF4Uxn7QyvQD
 qczrgjyUkWsMJG2M/080p5K1yect84gTUeynl38sbij8JTD5e1JctujSKyaz0zrBU94zr6aC+
 Kcc/9aCGgZMI2sO4q4MM0l9v/plALKdrrmpnCYqY71NpAj/hQas36LAiieXmNI0L6Jean3Xy0
 c3df5cZ23mCuAr2R4H1qeIqLcU4R4wl1OG0jqdMK7CUn3YCVyeYArAkHt/6amloyYM9rrGKck
 5E8m7jZl6Xdvh98+qXMlmupmoMsNaR5SO6GoHeux/nVTLwp8SrC5yBrujB7FQbRSU6sGwNLm1
 82ha689yeShSsb/5nSwEcbpZ78IpHjNUTbWdRMx+1LOukNG88MprgFVpf6CTMPI5zkmRxMMJt
 82IAk1ThCWGa1xwOsbUyjJXXnFE0aALAlra7mPyz7d2fCjhqOZU7OQjq65O2XSnWeUqqIgciY
 GsltmlavurNc1lkuM69HtpTpfEBtVBHea5NdrZTI8Nxq6aRipjDECInc2WPGuWCJA2dmDQUN2
 AXeYINWGZqfYX4SeNFWM9A0E32wIoWXoxgxgwR39LLRDkIMVBwodKuDvQ24Vdx+t/4+ex2D9V
 K1kwWcvBGjrTMme3Qj6GaRFnqWJd5z8ts+3aXooyqRkjKqQnkfkY+AFnqpelUm+zSn5KUVJD2
 Tdx/mLiATI1RF691sZUFsngljbkRKc758aX0yR4QbkB6TbcKQWNhqmLJ1qkrgFrfE9A35YdBE
 R9JLwHYDrklhu0GEQMaNmoXsbTNHVZ0EdptlwCRBMUaPP0cGE3kLy0TDRzpj1sDKcYmn4REfW
 VA3f7wt
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello world;

=C2=A0
I'm trying to set up an access point with kernel 5=2E16=2E1, hostapd 2=2E1=
0 (compiled with CONFIG_IEEE80211AX=3Dy) and an ath11k WCN6855 interface=2E=
 (Emwicon WMX7205)
However I don't get high bitrates and only slow data transfer rates (6 MBi=
t/s)=2E
Does anybody have done this successfully and post his hostapd=2Econf and f=
urther advices?
=C2=A0
Thanks
=C2=A0
Frank-Christian Kruegel
=C2=A0
