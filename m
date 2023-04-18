Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92A6E607C
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjDRL5u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjDRLzs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 07:55:48 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D3769F
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 04:53:53 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f40b891420so2384305f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 04:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681818832; x=1684410832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Le/IzLBZIve88XgqgZJCLLokjCnnuGyJJ/6tjOu1E4=;
        b=iKgib1UNkNMchYvtlQgoc8l4M5WtDTTcpeTdf5vMXFkmn1WmtpEeDcZlbSg4P35kyZ
         lhjFypLE4nSS+qeJoFf2aORJOiTDCFWXr1EngLf/jrSsF5mGw15MhPB1WpDzQ2/YpvTA
         Or2uFy4gmzOG3FRfEAqePEUt8mSYIJJweqQ9jQ0+RljmDUU/gpV4FWlxfm/ZQQCnhIRE
         cQmD33i3bAZOufhGvvxm09NuUGvg2qbOXF86A1cKwz++boMU0LhN2nkFlrWy7l4Ne/Ab
         5PC0uiXMxYNTlQXPjf8lm/GXjBR15IWcLPp10FttmzE4Jm5VThT6EnTeIGNcs//MIhGf
         X6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818832; x=1684410832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Le/IzLBZIve88XgqgZJCLLokjCnnuGyJJ/6tjOu1E4=;
        b=X8KkQ+jZSriw5BGriGmijjNhQtQd2peO2YwVfRZT1mkTuqk0qwMUW2kSPACF4uaGmR
         QIA0jkPnD8sRibuNYz+qPL6p+TBFHVSvqXCpeeKx+pDOvXqI0Y+iTYuQc8SDoYvSlRjj
         yVpl42WVOBGRQfGLVtDUgw0+vthi+ICr8zfASiMfi2TD9JMHbG1OFTvK+g3uP+DZKqMG
         RlAI489e6tT4TwLUMogzpoE0CN6R1wX7nYX7ePJ4fSvahGShIFmeDIw7jWiY/yGUXvhy
         JAbibUM/6ks/p2ytaIMdKGKCER0Xwr+VCk+lhTEkV8Gocg3CdqantbVk2Wv5v+kzTXqr
         FOwQ==
X-Gm-Message-State: AAQBX9cP/PTnvFflo8TL+ST1fyUF+2m2UxAe1RUufnXPgrOQ4/C5bMf8
        K/5Ry8oh7ubeVT/kmv8FcRLAK4TOwjFn4T2M1UmkJpZecjQ=
X-Google-Smtp-Source: AKy350aQ7wiMt7TSN/maAix8S/bU8JA57UbvVvBfJ7CUqfqxFSSmzoe8Ggz9Xa84NGDbyV075o+zTQhmyE7PzC/oxVI=
X-Received: by 2002:a5d:5958:0:b0:2f9:896a:7554 with SMTP id
 e24-20020a5d5958000000b002f9896a7554mr1599381wri.13.1681818831572; Tue, 18
 Apr 2023 04:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
In-Reply-To: <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Tue, 18 Apr 2023 13:53:41 +0200
Message-ID: <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Am So., 16. Apr. 2023 um 19:47 Uhr schrieb Bitterblue Smith
<rtl8821cerfe2@gmail.com>:
>
> On 16/04/2023 16:45, Artem Makhutov wrote:
> > Hello,
> >
> > I am not sure if it is ok to write to you directly but I could not find a place where to open a ticket about the rtl8xxxu driver.
> >
> > I am having issues with the RTL8188EU (LogiLink WL0151A) where I get truncated packets when sending large packets. It's easy to reproduce with ping:
> > [...]
> Hi!
>
> Adding linux-wireless because that's the place to report bugs.
> Also bugzilla.kernel.org, but that's more dead.
>
> Unfortunately my TP-Link TL-WN725N is fine even with bigger packets:
> [...]

Yes, I also have wifi networks where I have no issues at all. It seems
to be only related to some wifi routers.
With a Huawei AX3 router I have no issues. But with an Asus RT-AX53U i
am getting corrupted data.

> What version of the kernel/driver are you running? On what kind
> of computer?

It is an embedded device with a STM32MP157C processor. It runs an
5.15.67 kernel from ST (https://github.com/STMicroelectronics/linux/)
I have backported the rtl8xxxu driver from
https://github.com/torvalds/linux/ to that kernel by cherry-pick all
the related commits.

> Did you use any module parameters?

No, I have not tried any parameters yet.

> Do you know if the other computer is receiving correct packets
> from your RTL8188EU?

I have no ssh access to the router (it runs the stock firmware from
Asus), but I can try to do some tests on another PC later.
But I assume that it receives correct data as I can see a reply in tcpdump.

> What's the biggest packet size which still works correctly?

I think the magic number for ping is 1429. With ping -s 1428 I have no issues.

> Did you test any other driver, like this one:
> https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4

Yes, I have tried this one. Here I had no issue with packet loss, but
I was losing the wifi connection from time to time and the
auto-reconnect also did not work.

> or this one:
> https://github.com/aircrack-ng/rtl8188eus

I have not tried this one yet.

But I have also tried https://github.com/ivanovborislav/rtl8188eu

Here after some hours or days the wifi completely hangs up, loses the
connection and does not see any wifi networks any more at all.

> If the other computer is receiving correct packets, try this untested
> patch to see what rtl8xxxu is actually receiving:
> [...]

I have applied the patch.

For a working ping with a packet size of 1428 I am getting:
urb_len 1562
  pkt_cnt 136 pkt_len 1506 drvinfo_sz 32 desc_shift 0
[...]

For a broken ping with a packet size of 1430 I am getting the data below.
The strange thing is that the urb_len 1560 for a 1430 bytes ping is
smaller than a urb_len 1562 for a 1428 bytes large ping...

urb_len 1560
  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
  00000000: 84c405e0 21f0d700 30880052 0000104f 00000000 13283a20
000d002f 0000fcc2  .......!R..0O....... :(./.......
  00000020: 0000fcfa 3800c200 00000300 001e0f00 8400d100 00000000
00244288 561cf170  .......8.................B$.p..V
  00000040: eb50c390 142783f6 83f6eb50 05201427 00530007 00002000
aaaa0000 00000003  ..P...'.P...'. ...S.. ..........
  00000060: 00450008 1428b205 01400000 0a0ab438 0a0a0100 00006f00
be070a23 78050100  ..E...(...@.8........o..#......x
  00000080: 1d15643e 09080003 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  >d............................ !
  000000a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000000c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000000e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000100: 85848382 89888786 8d8c8b8a 91908f8e 95949392 99989796
9d9c9b9a a1a09f9e  ................................
  00000120: a5a4a3a2 a9a8a7a6 adacabaa b1b0afae b5b4b3b2 b9b8b7b6
bdbcbbba c1c0bfbe  ................................
  00000140: c5c4c3c2 c9c8c7c6 cdcccbca d1d0cfce d5d4d3d2 d9d8d7d6
dddcdbda e1e0dfde  ................................
  00000160: e5e4e3e2 e9e8e7e6 edecebea f1f0efee f5f4f3f2 f9f8f7f6
fdfcfbfa 0100fffe  ................................
  00000180: 05040302 09080706 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  .............................. !
  000001a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000001c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000001e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000200: 85848382 89888786 8d8c8b8a 91908f8e 95949392 99989796
9d9c9b9a a1a09f9e  ................................
  00000220: a5a4a3a2 a9a8a7a6 adacabaa b1b0afae b5b4b3b2 b9b8b7b6
bdbcbbba c1c0bfbe  ................................
  00000240: c5c4c3c2 c9c8c7c6 cdcccbca d1d0cfce d5d4d3d2 d9d8d7d6
dddcdbda e1e0dfde  ................................
  00000260: e5e4e3e2 e9e8e7e6 edecebea f1f0efee f5f4f3f2 f9f8f7f6
fdfcfbfa 0100fffe  ................................
  00000280: 05040302 09080706 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  .............................. !
  000002a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000002c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000002e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000300: 85848382 89888786 8d8c8b8a 91908f8e 95949392 99989796
9d9c9b9a a1a09f9e  ................................
  00000320: a5a4a3a2 a9a8a7a6 adacabaa b1b0afae b5b4b3b2 b9b8b7b6
bdbcbbba c1c0bfbe  ................................
  00000340: c5c4c3c2 c9c8c7c6 cdcccbca d1d0cfce d5d4d3d2 d9d8d7d6
dddcdbda e1e0dfde  ................................
  00000360: e5e4e3e2 e9e8e7e6 edecebea f1f0efee f5f4f3f2 f9f8f7f6
fdfcfbfa 0100fffe  ................................
  00000380: 05040302 09080706 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  .............................. !
  000003a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000003c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000003e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000400: 85848382 89888786 8d8c8b8a 91908f8e 95949392 99989796
9d9c9b9a a1a09f9e  ................................
  00000420: a5a4a3a2 a9a8a7a6 adacabaa b1b0afae b5b4b3b2 b9b8b7b6
bdbcbbba c1c0bfbe  ................................
  00000440: c5c4c3c2 c9c8c7c6 cdcccbca d1d0cfce d5d4d3d2 d9d8d7d6
dddcdbda e1e0dfde  ................................
  00000460: e5e4e3e2 e9e8e7e6 edecebea f1f0efee f5f4f3f2 f9f8f7f6
fdfcfbfa 0100fffe  ................................
  00000480: 05040302 09080706 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  .............................. !
  000004a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000004c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000004e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000500: 85848382 89888786 8d8c8b8a 91908f8e 95949392 99989796
9d9c9b9a a1a09f9e  ................................
  00000520: a5a4a3a2 a9a8a7a6 adacabaa b1b0afae b5b4b3b2 b9b8b7b6
bdbcbbba c1c0bfbe  ................................
  00000540: c5c4c3c2 c9c8c7c6 cdcccbca d1d0cfce d5d4d3d2 d9d8d7d6
dddcdbda e1e0dfde  ................................
  00000560: e5e4e3e2 e9e8e7e6 edecebea f1f0efee f5f4f3f2 f9f8f7f6
fdfcfbfa 0100fffe  ................................
  00000580: 05040302 09080706 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  .............................. !
  000005a0: 25242322 29282726 2d2c2b2a 31302f2e 35343332 39383736
3d3c3b3a 41403f3e  "#$%&'()*+,-./0123456789:;<=>?@A
  000005c0: 45444342 49484746 4d4c4b4a 51504f4e 55545352 59585756
5d5c5b5a 61605f5e  BCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`a
  000005e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
  00000600: 85848382 89888786 8d8c8b8a 91908f8e 95949392 330f81a8

Thanks, Artem
