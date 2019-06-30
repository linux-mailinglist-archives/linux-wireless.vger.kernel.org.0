Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6475B22C
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfF3V4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 17:56:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36047 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfF3V4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 17:56:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so12652574qtl.3
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2019 14:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txuRTylzO9HtqJ05wnC3L8NyCMNOBefcP6c96hmVIc0=;
        b=iYDuBFwlgSIM4o8Gs9dF5EPe3xx4UD2AEDnpMMyKHpjvhniiKH/kGgoa+dmX9wWHyT
         k1tTYSjB+/a1bz3Ujl8RzAZUEUn7kPkC6HZrzSjvmGgnYLVc5/La12JiVUttkRiVQSLl
         8RYahrVREc94zRvBWwKWc7DCUzNS0EjYhrHTFStLDXoIMqh7Zw7WGe7s54GvtG9QjbPw
         vPiX5pGYjQUrLofd9FnyTGSHzoajk+SXvfpzDWt3HeMjdVNpFl+nqtpus/JSVvgumVzB
         ARjvc+RQZyaJNZ1XU4UYmQgv/GGUSfKopZEo16QIbbrZp/OL1mP9ETpKXsYTm/QlxtBR
         IBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txuRTylzO9HtqJ05wnC3L8NyCMNOBefcP6c96hmVIc0=;
        b=tqrydy6g5Yoqvi0TgQqIiYBkIVimPEw1vjzpyZSzILPwpeav6NyFtEMPcASAQh/g+F
         Tj9Tbh1hMG6UdGADEVXTX3kHzklhCK8U2q817ydxDsKKVnYrj+IASYwGCR6h0ZqQZLPC
         dAK/p1EORr1yOKv61Z+dTAXRFcBqdG37GLiqMQTcpscFSN2zxgS1AxRFXRGzIlEpDdkt
         E8+8TLBzBcZMmkbSkfgEAlbCD61dSPExbz2fnRja2rQK3XilQjiL79cp6/mzL6DtLci3
         NKA1ykgUFCwQvxw22vdMlxgYRivWO2wgzVFZJTD6XLjye0JUEdMbaqGgxiE8Mus2Sjn5
         ZXLQ==
X-Gm-Message-State: APjAAAWoBqYmmbV8ybUH5WkhLF23vzbESttqrkkoq4fky8s4oDWP7/qW
        JCzB2mEE1zargUks7tzFIcjrF4OoSjQa/jQoTjlmZ4gt
X-Google-Smtp-Source: APXvYqw5wJGM/H8BAlmYh96dCgrPIfku2q8wBOD+t1J39JQcB1e7ZuYKlzUxxMmdo1dQmgqvKZp5Dmn0KGZxNXpi3sw=
X-Received: by 2002:ac8:34c6:: with SMTP id x6mr17786931qtb.353.1561931805131;
 Sun, 30 Jun 2019 14:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOw_LSHsioZ2TP1FeZT3L6gHeeV72e2aKW0bGkAzcJRgVzE43Q@mail.gmail.com>
In-Reply-To: <CAOw_LSHsioZ2TP1FeZT3L6gHeeV72e2aKW0bGkAzcJRgVzE43Q@mail.gmail.com>
From:   Daniel Lenski <dlenski@gmail.com>
Date:   Sun, 30 Jun 2019 14:56:09 -0700
Message-ID: <CAOw_LSF5kBQCECi+1waXNMvuo+eT68fr9SO52JMuVrLtq8_CLg@mail.gmail.com>
Subject: Fwd: rtl8723au: WiFi scanning stops working shortly after driver loads?
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
I recently started to use an older laptop with RTL8723AU
WiFi/Bluetooth again for the first time in a couple years.

I've noticed a strange behavior of this device/driver (rtl8xxxu with
4.4.0 kernel): the ability to do a WiFi scan *while associated with an
access point* somehow disappears ~30 seconds after the driver is
loaded.

That is, right after loading the module and connecting to a WiFi
network, I can successfully do `iwlist wlan0 scan`; but after a short
period of time, the scan stops returning any results other than for
the AP that I'm already connected to. Disconnecting from the AP
"resets" this behavior, but once I reconnect to a network, my ability
to scan disappears again shortly thereafter.

Steps to reproduce:

    # rmmod rtl8xxxu
    # modprobe rtl8xxxu debug=99
    # while true; do sudo iwlist wlan0 scan | grep ESSID | wc -l ; sleep 2; done
    13
    13
    13
    13
    1     # only my current AP
    1
    ...

Is this a known issue with the hardware, or with the driver? Any
advice on how to debug it? I've looked through the debug messages, and
found nothing that seems to indicate a state change around the time
that the scan stops working.

Thanks,
Dan

ps: I'm using the "standard" rtl8723aufw_B_NoBT.bin firmware
(https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtlwifi/rtl8723aufw_B_NoBT.bin)
and have loaded *only* the WiFi driver, *not* the Bluetooth driver.

[ 3110.201258] usb 1-1.4: Vendor: Realtek
[ 3110.201267] usb 1-1.4: Product: 802.11n WLAN Adapter
[ 3110.201274] usb 1-1.4: RTL8723AU rev B (TSMC) 1T1R, TX queues 2,
WiFi=1, BT=1, GPS=0, HI PA=0
[ 3110.201279] usb 1-1.4: RTL8723AU MAC: 20:16:d8:ce:5e:29
[ 3110.201284] usb 1-1.4: rtl8xxxu: Loading firmware
rtlwifi/rtl8723aufw_B_NoBT.bin
[ 3110.201355] usb 1-1.4: Firmware revision 31.0 (signature 0x2302)
