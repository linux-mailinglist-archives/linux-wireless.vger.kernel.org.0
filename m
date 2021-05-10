Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06DE377E48
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEJIgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 04:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhEJIgv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 04:36:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06B1C061573;
        Mon, 10 May 2021 01:35:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q127so14608717qkb.1;
        Mon, 10 May 2021 01:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Dv5HZ1iIO9k5TBKjdbjTq8arFFrPhJ667CSCrAmKd5Q=;
        b=pm7b0jYqffnMRJ14/JvwQpPuM2LyZDzPuTGnxM8fBagtpnFcHTXR9yQFI7nXJ+1RZf
         gsnooT1/ja5vG3mmtk50gmTMkFxftv68hrJr5JfI3YdphAunE0puYIfVvuXcwJXxUlHj
         CDodkEYrWjPwhxgtzJO0htCHn6MDn4FjrxXqA7oieZUyiPWKus/Bbif5kNSoBLHcc/ZM
         6ldFQ+UL7nRrbsOT74hBgCDdanSS6khUfCOAznLV0C/mKLwCc4UgTkvMeNzH6PmhmgHH
         VSJB7Cg9xsggsosY3uI8rWFx4KvUfLmbKrf4ef3EzTRpjJIzLRQX+mgt+IuCvPG0GfFn
         gCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Dv5HZ1iIO9k5TBKjdbjTq8arFFrPhJ667CSCrAmKd5Q=;
        b=QbRVl1naJ/NYV0Fh6/bkdMyG5MuFhhUMhxi9tZj0GxyXH7iGph6xOdJOz/XBcsv6IS
         3aEzWO7Cstf0KxzVkBW4s/E50bkIq4Z79m2DIAa7ZZscqf/iHj4nWIikLLOjK7xZSxlz
         rsjFX6IzQr+KgY8UNPvRCQGeHL14zWQ+q8U8mPuMWFyPbnhNCGYFcNVyd913H97z/f67
         ipfooh30O6p2KIQUvxfRkzsOQJp/P7O0Tc4c/cJrifokCgz6d/+T/GIPoaX1UNRZ4fdJ
         gUmjvV8r99bwnGP1OGxh8ft28Prh5G2Nx8TZu6helwV2wX7hW17ai6hgn1OwKBrP1LYD
         HOYQ==
X-Gm-Message-State: AOAM533K9FQukAFw0DKlxWZFjoUiv+PF7ZhqiM1zFFJMwrkkJg92UJ2D
        vhARGUbSOhwEWd7J4VAS+DPDoziHmHak32TZHLQ=
X-Google-Smtp-Source: ABdhPJxIxEHt8pfSZ2Lb+aPIyCea3bUMDdddxPoi8T3diGXSoKu21U29wwHHaNb2iTJg0AIzBuQM6SzzQ2J0oe8IP1g=
X-Received: by 2002:a37:9e44:: with SMTP id h65mr21954031qke.297.1620635746055;
 Mon, 10 May 2021 01:35:46 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6YKx5ZCN56Kp?= <ccchiu77@gmail.com>
Date:   Mon, 10 May 2021 16:35:35 +0800
Message-ID: <CANgQ54dicgKSZFm3w9sbAYztFw9xBHZnt8aQMNCEfMn_twBbWQ@mail.gmail.com>
Subject: How does the rate adaptive mask work on Realtek WiFi driver
To:     Pkshih <pkshih@realtek.com>, Andy Huang <tehuang@realtek.com>,
        Larry.Finger@lwfinger.net, kuba@kernel.org, kvalo@codeaurora.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi guys,
    I had a problem while verifying the ampdu tx throughput with the
rtl8xxxu driver on RTL8188CUS module. The throughput number is
relatively good, 39~42Mbps  TCP on 2.4GHz channel. However, the
retransmission rate is high, it's 15% ~ 21% with rtl8xxxu driver and
It's almost the same result with the rtl8192cu driver. I can get
averagely 7~10% retransmission rate in the same test bed with Realtek
vendor driver.

    From the air capture, I can see the rtl8xxxu driver keep sending
the aggregated frames in MCS7 and doesn't even fall back to lower MCS
index in the subsequent retries. I can only see very few retried
packets been sent with MCS0 or 6Mbps grate. On the vendor driver, I'll
see the retried ampdu packets with MCS4 after 3 retries w/o ack from
the receiver.

    From the rate mask command issued by the h2c command, I force both
the rtl8xxxu driver and vendor driver to use the same ratemask 0xfffff
(MCS 0-7 and b/g rate included) and leave the arg0 as-is (mostly 0xa0)
and I expect both drivers can do the rate adaptive thing in the same
way, but it seems to make no difference. The rtl8xxxu driver still
sends the packets with highest MCS.

    Can anyone tell me what should I expect the rate adaptive to work
with the rate mask 0xfffff and 0xf0000? Does the 0xf0000 means that it
will pick up a tx rate only between nrate MCS4 to MCS7? I need a base
line so that I can judge it's simply a rate mask problem or maybe the
h2c command is not written correctly. Please kindly suggest what I
should do next. Thanks

The rtl8188cus vendor driver I tested is here (It can be compiled with
kernel 5.12+)
https://github.com/mschiu77/rtl8188cus_vendor/

Chris
