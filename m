Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693FB20C988
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgF1SYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1SYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 14:24:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBDC03E979
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 11:24:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so15636840ljc.8
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXNSPBfUhAO6418RORl5yWBp5UnrK6P4WKnM9fr6Znk=;
        b=onNAJ/uJ9h1zaAh8a0CIOYTu5/ZgWA3IIcY52atwGVJOhrhvl7J3Ad+YZRi7N9yh5f
         GaaW2BMZiKbCYe4QTDiNIV9UMCWBUuuQPOHqIsH/W9tWzqrEcdwzboVYVu1eP8xwIQZE
         N5vILLWinLmtEcs5GhywFLvoLpTesss3+dGAtg3cFyrMLbLByxJXmh3FhjERgncl6/Mp
         1U4rDcDgUvCru0nViCFx2tKzxrBCxhB8hOiU8XZUJGivOPT5Pio4+F29s6yvIsCfxiy0
         b9s05ecpSK/7lqYlFStMyXXnZrXs6Tff0E03CBKXDg7fAKfdqlX9bCre87H0bWvutHLW
         lCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXNSPBfUhAO6418RORl5yWBp5UnrK6P4WKnM9fr6Znk=;
        b=SUSNVOms5e7sqwopa5FIlHXijieVLnDo76Bwherw6fcJTuaLZkJgKv2QyDuAyIt6N1
         JsfH3QAWfZNkSAF5Oeq6iENhQu01I+laRQgh+lb6qM6CTD/2MsuN4f7VmQoTPfQhJVBu
         f/Hk/LYHz5c/4+k76fQ2S9+fbpZ8/spuS7c6cOw3gAuYgHkYDqC1Fkp7E0PK0RqXNPJh
         11HwUEYGIL2ZSYhhiKkrQ+Rycif2qLBLqCO0kqJGmmTkga90TcQktY/H6GDRCcSTzua6
         aWfYgJaZDzd64t92oRhcOlMmAmhI472lDvDleKthxJy0uwrtVDWfXs9pkMNMc4mwwQqq
         lMBQ==
X-Gm-Message-State: AOAM533ljNUzKQCXhqPuz0JRxyHBSriaA6086OAGfLeKdgg48kKM1/j9
        dGpEJViujp/CJ2Sd0vDjsnki+O4IqIabj2XkVkxsmCyHoBA=
X-Google-Smtp-Source: ABdhPJy+zIO6nKlzBtwZIkgWNS9hcDB8IEyt8pye6VbfQcIYxv/mb3Gx1NVc7zlnN2UzORCin6Fe2nSS/spJEpXnHVI=
X-Received: by 2002:a2e:9a16:: with SMTP id o22mr5989009lji.40.1593368691793;
 Sun, 28 Jun 2020 11:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
In-Reply-To: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
From:   Mathy Vanhoef <vanhoefm@gmail.com>
Date:   Sun, 28 Jun 2020 22:24:40 +0400
Message-ID: <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
Subject: Re: Alfa AWUS036ACM (Mediatek MT7612U) AP problem
To:     James <bjlockie@lockie.ca>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have similar issues with an AWUS036ACM when connected to a USB3.0
port. When connected to a USB2.0 port it seems to work fine.

In particular, on both kernel 5.5.0 and 5.6.13 on a USB3.0 port when
running an AP I get the error "mt76x2u: error: mt76x02u_mcu_wait_resp
failed with -108". On the same kernels but using a USB2.0 port the AP
seems to work properly.

On Fri, Jun 26, 2020 at 11:33 PM James <bjlockie@lockie.ca> wrote:
>
> I have an Alfa AWUS036ACM (Mediatek MT7612U).
> My AP keeps dieing.
> The error:
> mt76x2u: error: mt76x02u_mcu_wait_resp failed with -110
> seems to be common.
>
> I use it with a build of a OpenWrt on a Raspberry Pi 4 (Broadcom BCM2711
> SoC, ARM Cortex-A72 processor (64bit)).
> Linux OpenWrt 5.4.48 #0 SMP Thu Jun 25 00:36:19 2020 aarch64 GNU/Linux
> Loading modules backported from Linux version v5.7-rc3-0-g6a8b55ed4056
>
> # lsmod | grep mt76
> cfg80211              339968  5
> mt76x02_usb,mt76x02_lib,mt7603e,mt76,mac80211
> mac80211              589824  7
> mt76x2u,mt76x2e,mt76x02_usb,mt76x02_lib,mt7603e,mt76_usb,mt76
> mt76                   45056  7
> mt76x2u,mt76x2e,mt76x2_common,mt76x02_usb,mt76x02_lib,mt7603e,mt76_usb
> mt76_usb               24576  2 mt76x2u,mt76x02_usb
> mt7603e                53248  0
> mt76x02_lib            61440  4 mt76x2u,mt76x2e,mt76x2_common,mt76x02_usb
> mt76x02_usb            20480  1 mt76x2u
> mt76x2_common          20480  2 mt76x2u,mt76x2e
> mt76x2e                20480  0
> mt76x2u                20480  0
>
> I bought a powered USB3 hub and removed a USB3 cable in case that is
> related but the problem is still there.
>
> I've been documenting my problems:
> https://github.com/openwrt/mt76/issues/405#
> Are any of the tracebacks useful?
>
> I found this:
> https://github.com/openwrt/mt76/issues/403
> >
> >
> >       *LorenzoBianconi *commented on May 10
> >
> > @petrkalosthis conditions is used to reset the device in case of
> > necessary (it is in the vendor sdk). You can try to comment it out and
> > see what happen
> >
> I downloaded
> https://d86o2zu8ugzlg.cloudfront.net/mediatek-craft/drivers/MT7612U_DPO_LinuxSTA_3.0.0.1_20140718.tar.bz2
> and there is no "mcu_wait_resp".
>
> I also found this:
> https://github.com/raspberrypi/linux/issues/3014
>
>
> What 80211.ac USB adapter has the best (most open and compatible) now
> (or likely) linux kernel support?
>
