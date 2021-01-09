Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203932F0258
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jan 2021 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbhAIRkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Jan 2021 12:40:08 -0500
Received: from mout.gmx.net ([212.227.17.21]:49345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbhAIRkI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Jan 2021 12:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610213917;
        bh=qM+OeweENrlE+Rh2i4NWyt+Hb+arjcP4/86KHPApQHo=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=bB7g4Y1CbYAAMtP8OW4tz+gHsjJvZU2YTMkb/FbIhQryA93jpY9bsKLsxThzfOSrs
         SUoBohkhquxX0uVsTIHxsuzxeXlKDSA8V1dXjk2ewmBKuWmQ7rPoWubZvLPc20S/rR
         MhsNI50egKYNl7cW/8WhqJ8s6CAbzl4gRT+z/utw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.78.229.53] ([87.78.229.53]) by web-mail.gmx.net
 (3c-app-gmx-bap09.server.lan [172.19.172.79]) (via HTTP); Sat, 9 Jan 2021
 18:38:37 +0100
MIME-Version: 1.0
Message-ID: <trinity-482e0b11-3de4-43e9-af4d-331df16e92a1-1610213917051@3c-app-gmx-bap09>
From:   Matthias Berndt <Matthias_Berndt@gmx.de>
To:     linux-wireless@vger.kernel.org
Subject: How to get RTL8821CU into mainline
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 9 Jan 2021 18:38:37 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:aj6ffs2CMyOnrpkgPW5/R0ednjfF+Yrrb0ZgJhp4koKMHT6pqsd/EkYjpDgXhsPKuQgb2
 jQkfkcNL+vLDeyLuiO4Fo340LtRZOqlize90nae7Wl79qdJLIwPAacPN5zkqdxl3QHnNLykFAjNF
 z5raWRkjP7GYXoM3AwXlzCeliPHg1LdeO9CvkXgwE3ojhVerxUkrPBBPV2AtsYW1tGIGJYU/ywqo
 /MLAOqlsIVgBsTJBrD7DzvNkO4PN3sUptR6enwuO0pGdAYkwB+QJQIX3dyTUGYg9zgTTY/fe8Ml8
 5A=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3EXpOore4SU=:CZ0GcIrWvGABX3FT2rSDrb
 7zwyKa/kRZwBMU4q2VEhYrM9Ra1myXpyEbShgARs/x9WgB6mQqCEX31DeoOX75TmThZlzutX+
 cQeMZSCeGDwFXdhEpfPrpMB3k1LqvHygzGa7EK1SJ5C+CvDm+yNtab2ucIIv8TgdRDczp907o
 PxEvTkMdjKIQ4Jb9PlW8wKtTM18CD7JGvajkJ/b7ACIgIiRgbVkBLv7+eb1YSBz8D3A7z8cDf
 VTF3hLaVH4TT89dMxtgQS3m4x9Mv55RfSzW0HZXmxW2bm7yHwq/XtNc90xvLNZ27FI1cOLYzY
 4QVDTZy5qCIbASlQGBnyu1aW7VaMxsg/+d8MR2ChBlmRXk5W9H8DKIv1omI08nKWukb5acYz3
 0vNZyY5+SGfFPUHwatXVIpxgThyLXdu4VK+s3SMDju6hQT4r1Q3c3uDAGn4GZIkeTgf/A2Y0V
 r/58o+IRUVZMZyIL857o3/ZhQURDFCXo1ux/6Qf5eXKJe9FjgUNSE36b8C11128tKP9vGgus+
 UUNKjKhpbcOTQn3tQE7YkuwrnxbaU6ZQxLATP1iRDBBcFUnwkk8ADEhHAFOyosAMYgNhcwX7M
 xc/f9Xwp2EZms=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi there,

I've recently purchased an USB Wifi adapter with an RTL8811CU Chipset.
There's a driver here, it's open source and it works:
https://github.com/brektrou/rtl8821CU

So my question is, what's missing to get this into the mainline kernel?

All the best,
Matthias
