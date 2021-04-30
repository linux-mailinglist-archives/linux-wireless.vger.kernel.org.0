Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EEF36FB82
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Apr 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhD3NdZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Apr 2021 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhD3NdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Apr 2021 09:33:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A99C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 30 Apr 2021 06:32:36 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so105239678ejc.10
        for <linux-wireless@vger.kernel.org>; Fri, 30 Apr 2021 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=oF+ICJkbu5LoXxVUwXe4c7GYRFnEqSUmj0Ub0V2/4Ns=;
        b=Vu6patht7+53CpuPDKhi0L6t8GpkCbbxgtj4T1+v8tWBaFgAtgZ3OPHZtbB251V/pq
         6tN9JgIJxBfVYo2MD5d4T7kTCxDKVgOYJBenoJEWcDRLABgCuuHqmEGZM7hdHnPTw9qZ
         swGUxCWWGGHsV8ScgjTz30ILcemgKuxdzZDuJh57/r9UQ0OypcTaDyCBSDlwNliPCoVD
         Ipj533jV6GKeJVzPEvb6Oubb+23KeAjyvtZ4snB3uf19oBgW04SlHIa0NuSp11SO+ZUV
         MK63U9KjZX5R0ZHXJxcAI38h4br4oMc789USKdrpBuGam8MWP0OxcBbsSh/0mbDvnQ+B
         lKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=oF+ICJkbu5LoXxVUwXe4c7GYRFnEqSUmj0Ub0V2/4Ns=;
        b=jsxA581+oGU9J60fMR/rAGEoKISKn6hKHLS0/dYWfMVe1neFlKi+iw9Hr7kOCU7i4+
         0twcFt1f3eJvWgKf/n3pe7/5UW+uP1Ffh+8diWGh/URrvd59FgFZsS1bPsZFCsUTljGB
         79Dqjnq0i78WOhWQx8OiO7Ircf3OavQf88uln0ZiA2eFWKMJPVmbLZl8t0X1xCQ4lZ5V
         r5q5l4tYiIvVO6NcUPG9iUJ+tQx8+Bl2EkZ5PnypwKeh2Eet5jDEjHJWN/qjUFvpzMic
         GxwDiZRSJYrict/OEyyVrbWS39KBe1ctylZeJ0GY2syt9/4tyhl6UkW7QzYk/IkrEXmP
         9P2Q==
X-Gm-Message-State: AOAM533YNvw29ogkLeh3SPMh+/k328wjxQgHsfjIH0cR1+ZzpDmEIccF
        HbXUkED3bJMhjcSXzoRmaVW1srxxBlVVhq66zw==
X-Google-Smtp-Source: ABdhPJwsPnKJvjvforomtRHpwpi4rDE9BfLSZJw/Lx2r0M6bzkYCLdtPpJkL7m0oo7wSipHq3AIDZfH6wrRRtKv6k5s=
X-Received: by 2002:a17:906:5791:: with SMTP id k17mr4293783ejq.296.1619789555509;
 Fri, 30 Apr 2021 06:32:35 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 30 Apr 2021 14:32:24 +0100
Message-ID: <CALjTZvbS5RtarO6sZUTg__VqB+MmJMpMz9k6CwZ9u8dq68u23w@mail.gmail.com>
Subject: [BUG?]: mt7601u broken on 5.12
To:     lorenzo@kernel.org
Cc:     kuba@kernel.org, stf_xl@wp.pl, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Lorenzo,

I'm having issues with my MT7601U dongles, they're not working at all.
I'm seeing this on current 5.12 (it's cyclic, loops after the USB
disconnect):

[  660.810386] usb 1-7: new high-speed USB device number 119 using ehci-pci
[  661.031390] usb 1-7: New USB device found, idVendor=148f,
idProduct=7601, bcdDevice= 0.00
[  661.031400] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  661.031404] usb 1-7: Product: 802.11 n WLAN
[  661.031408] usb 1-7: Manufacturer: MediaTek
[  661.031411] usb 1-7: SerialNumber: 1.0
[  661.200379] usb 1-7: reset high-speed USB device number 119 using ehci-pci
[  661.403137] mt7601u 1-7:1.0: ASIC revision: 76010001 MAC revision: 76010500
[  661.404566] mt7601u 1-7:1.0: Firmware Version: 0.1.00 Build: 7640
Build time: 201302052146____
[  661.828765] mt7601u 1-7:1.0: EEPROM ver:0d fae:00
[  662.005518] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.005525] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.010015] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.010020] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.014269] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.014275] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.018516] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.018521] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.022768] mt7601u 1-7:1.0: Error: MCU resp urb failed:-71
[  662.022775] mt7601u 1-7:1.0: Error: MCU resp evt:0 seq:5-4!
[  662.022779] mt7601u 1-7:1.0: Error: mt7601u_mcu_wait_resp timed out
[  662.350350] mt7601u 1-7:1.0: Vendor request req:07 off:0080 failed:-71
[  662.650344] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
[  662.950339] mt7601u 1-7:1.0: Vendor request req:02 off:0080 failed:-71
[  662.950389] mt7601u: probe of 1-7:1.0 failed with error -110
[  662.950850] usb 1-7: USB disconnect, device number 119

Any idea of a possible cause?

Thanks,
Rui
