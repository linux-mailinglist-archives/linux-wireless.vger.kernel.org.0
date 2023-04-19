Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635E6E82A7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDSU17 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDSU15 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 16:27:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617404ED8
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 13:27:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q5so262414wmo.4
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681936074; x=1684528074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OQYJWIUN0EVDtc6NMEvB+qMW/lJl4SlH8ak+IcLQfbQ=;
        b=nUJXaVVddJ63r9M0SPQTOSQngjh66vCFjl15WghX/iVYM3tTayZCWjUa9MMoJck/0/
         u5imNQd7r/E4EHJYZjRs0b9O14FN41x/qOORoq0zDqicv6eEdk1KyQz0kXjTinuZ6vzD
         v0EshSXCtLGZafjVc2G3c0SVqchcn9sPcDwj6VYIDq1K267h1Rcn9Kh43U9sIzj7owQd
         rOo9Rgi3QknuIjkFTq8VN0jcWknrcP4vE1xqYluulf5cRitowrlMINd3bKSYuuDaD2bP
         oxCwY9a7gwtC6ziKrUDbi1Teq8BXg7cJClQO0aBX3Eu8qmFSUPcY9fjdoxSWgswOijB2
         Xvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681936074; x=1684528074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQYJWIUN0EVDtc6NMEvB+qMW/lJl4SlH8ak+IcLQfbQ=;
        b=ccDUnM853oCALI450ikcNLfS1bPk1VIzYXttJpzbqUCyxzFTnKoFovMSvWbTn6LSZK
         3rKD6hn3oPocGm6AwOxej+MZdcP0mxAmsJnzG0MkEZuoMFfXIFo0YtLZ2xBjqqcSDZi8
         B90WvgOZS+it49tsbFmMeW9owkw6F4yK33/hDIePdY77E96vucvykToWC6JCiTRiM1zT
         jlQCa4HHw4Zu48ioGJpTixYUXP3ILsQrG/cGT6/SJvsJNLToGo6KMna6J8C/6NtVYbnd
         EVnEM87kmVBh61ZpqapYO04uZeOQbnsY5o8+uQlgf9Gig/w7ysej/3tRDYpA0u5zjWLk
         ibqQ==
X-Gm-Message-State: AAQBX9e2JTAP+cUKuO0pux8FVEusL2bWm/cE+gce7z+/OSavDndAef4M
        +O0Nr9QQ74ukng3NXc5EihiDT+yma+4mQVQDAt+Ixtmrnps=
X-Google-Smtp-Source: AKy350bW60sxNg5t2TIV6BeXpeKg2cCSqhYPPBynoUKrTlCxP2KclnVFTfuEyV21eo2hfxjY5WukCzOCfj6LugqzehY=
X-Received: by 2002:a05:600c:3652:b0:3f1:71b2:9445 with SMTP id
 y18-20020a05600c365200b003f171b29445mr11842802wmq.15.1681936073595; Wed, 19
 Apr 2023 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com> <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
In-Reply-To: <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Wed, 19 Apr 2023 22:27:42 +0200
Message-ID: <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
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

Hi,

> Interesting. Can you try rtl8xxxu with the newer v28 firmware?
> You can download it from here:
> https://bugzilla.kernel.org/attachment.cgi?id=304160

I might got better using rtl8xxxu, but I am not sure.

ping -I wlan0 -s 1430 10.10.0.1
69 packets transmitted, 35 received, 49.2754% packet loss

Here are the packet dumps of a broken and a working packet using v28 firmware:

Broken:

urb_len 1560
  pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
  00000000: 84c405e0 21f0d700 30880012 0000104d 00000000 4a9c2c2e
000c002f 0000fcbb  .......!...0M........,.J/.......
  00000020: 0000fc06 3700c800 00000300 00200e00 8400d000 00000000
00244288 561cf170  .......7...... ..........B$.p..V
  00000040: eb50c390 142783f6 83f6eb50 01201427 00130007 00002000
aaaa0000 00000003  ..P...'.P...'. ...... ..........
  00000060: 00450008 515cb205 01400000 0a0a7704 0a0a0100 00006f00
f6137e0a 4cbf0c00  ..E...\Q..@..w.......o...~.....L
  00000080: 91606440 09080008 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  @d`........................... !
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
  00000600: 85848382 89888786 8d8c8b8a 91908f8e 95949392 5bbb8367
              ....................g..[

Working:

urb_len 1564
  pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
  00000000: 84c405e4 21f01700 3088001f 00001004 00000000 4cd774a4
000c002f 0000fdbc  .......!...0.........t.L/.......
  00000020: 0000fc06 4200c400 00000300 00210c00 8400d000 00000000
00244288 561cf170  .......B......!..........B$.p..V
  00000040: eb50c390 142783f6 83f6eb50 01f01427 00200007 00002000
aaaa0000 00000003  ..P...'.P...'..... .. ..........
  00000060: 00450008 8a61b205 01400000 0a0a3dff 0a0a0100 00006f00
661d9b70 4ce50b00  ..E...a...@..=.......o..p..f...L
  00000080: 04d36440 09080000 0d0c0b0a 11100f0e 15141312 19181716
1d1c1b1a 21201f1e  @d............................ !
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
  00000600: 85848382 89888786 8d8c8b8a 91908f8e 95949392 094523fb
5c8ab2b3           .....................#E....\
