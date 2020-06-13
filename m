Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67931F84E4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2020 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMTXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Jun 2020 15:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMTXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Jun 2020 15:23:41 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19004C03E96F
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2020 12:23:41 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v3so2619034oot.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2020 12:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0EzX6imgHUWXqf11CvCZwDze/NEEFAYYy7w+xbz+Y+Q=;
        b=SgeH6+vqRErM7xg3AN0Z93kDLj5Gs6hZJeS9A2skyh8HkFO7uPZX0yKJOWgUMUbzVy
         b5RzRFaV6S2qFwrPl9loDFMdX5jfNMXBH2ZKRT9DGs347JhLaERjjbkXnC5LHqi9aYox
         u3HiV8C+deU/xsy79/L4rAZjO37b8poe7JqEq5iCSusbV4Jl7NrYi9icsYpnpwcJ4Mg3
         ogbfHkCstDCMfzheHGxQhTXHMsbEa70Apl51aaN8nD4Et+TQLmKvT1M/ZokJjs/RbgFT
         XsscmBBMhA1RmKulSWOPnnXJ90ALQBWpdPTPgHacsTGo97Bz4TrAVsj/AcO1oNH5sbla
         KyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0EzX6imgHUWXqf11CvCZwDze/NEEFAYYy7w+xbz+Y+Q=;
        b=h+j5LIEmZo4Wi2xePrurO1gnnJ5mpreKFwH5U3FpVT9lZ/Dmafiy0svVRVvTTSVCGu
         FYhhWZrKuUblIXkavGANQUFaAY/S88uVQONnNtLQW4rtOD9oSOdV1NmqqCux1h3WUk0x
         aihQBfg/H7jKNU+vDlG+2RHKb2mNcPE/pD2XdKVh5oRkGAweEWDf6fyMA9Fj+R2YUZaU
         SIEQCqM0DPoAB/DmLzVD7gx6NuFOO5jPPB1IM1qDa51NOWDgAMguPfiuylFjYJXgsQM4
         u2+4SKVaI12tGrPklzESg9UGCIuQv4GpV5ppxkt2VwNFMpFo3T9WulUfithyQsLhICYE
         vXeA==
X-Gm-Message-State: AOAM531nvyqQfqDmCYpKqD9D3ftadHXSDSnx6YVkk1/5GrltOF8oZiLJ
        JvyardZoNxPtCLJvUpWpSR8yMhSkdIMNCt3sjaOt+eUY
X-Google-Smtp-Source: ABdhPJxsleSLE7TkH8ZG3MDxpF1eobDSa51dsuCvbVl6f2IgbTQ1hVhfU5p6VQp0FXPCDnmBx6bBelsb3VMj3J6l/k4=
X-Received: by 2002:a4a:3947:: with SMTP id x7mr15723051oog.55.1592076219603;
 Sat, 13 Jun 2020 12:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:940e:0:0:0:0 with HTTP; Sat, 13 Jun 2020 12:23:39
 -0700 (PDT)
From:   My Nigga <anomalousanonymousarmadillo@gmail.com>
Date:   Sun, 14 Jun 2020 00:53:39 +0530
Message-ID: <CALqii0=iXM_5pQFZU4sinB5soDkNzVLG45W=HJ6=NxaytHiybQ@mail.gmail.com>
Subject: [BUG] rtw88: WiFi speed drops randomly, timed out to flush queue 1
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Info about my system:
I have an=C2=A0ASUS TUF Gaming FX505DD=C2=A0laptop with the RTL8822BE WiFi
adapter. I use Arch Linux (Linux 5.7.2-arch1-1 #1 SMP PREEMPT Wed, 10
Jun 2020 20:36:24 +0000) with the rtw88 driver. I have NetworkManager
installed.

When it happens:
When I do not have a really strong WiFi signal, my WiFi speed just
drops by a lot, sometimes to zero, randomly. It doesn't happen (at
all, as far as I know) when I am right next to my WiFi modem.This
issue has been there since day 1 of me installing arch, I've seen
"failed to send h2c command" pop up in the live boot environment too.

Logs:
Whenever this happens, this=C2=A0message is spammed when I run dmesg (it
prints like 2-3 times per second):
[Sun Jun 14 00:10:47 2020] rtw_pci 0000:03:00.0: timed out to flush queue 1

sometimes it shows
[Sun Jun 14 00:01:05 2020] rtw_pci 0000:03:00.0: firmware failed to
restore hardware setting

and rarely it shows
[Sat Jun 13 23:38:08 2020] rtw_pci 0000:03:00.0: failed to send h2c command

There's also a stack trace sometimes, like this=C2=A0https://pastebin.com/S=
DhKpBdd=C2=A0.
NetworkManager logs don't show anything when this happens.

I'm sorry if this does not have enough info or if I mailed this to the
wrong place, this is the first bug report I've made.
