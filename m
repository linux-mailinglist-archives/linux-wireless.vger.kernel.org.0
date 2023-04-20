Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455F6E8BDC
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjDTHxe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 03:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjDTHxb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 03:53:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFF271B
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 00:52:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f1763ee85bso4292815e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 00:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681977153; x=1684569153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6nu6piTr0i1fYr31JjKQwjtY64D+bWACwQlhYUMdwU=;
        b=O949LiNrYGRBg2zgUdykyqFF8QnxPJqNNkWDhg5gXYDE2Wl2RvZA4KEiaWN6r7JeAI
         bgiEKe5T3F39AAkgxzZOoCUg7a3hyzGV0kVnHyHIJj+b8tV6iioacpfMG70C/VJU1sVi
         4+F+yv/2Jxqnlg4QnGtFSg6xe/Z79TRNwPt+O7vaY86+EG32nwbzQlDiP3Bq41I+X7KW
         9mTzfIxeS7plQnRJbJxw+RZOTi9x9DFJNBK6c1IjbeHV4SmopPt6DpULdaScLq7Il3U7
         q3IODDzVSd/NIFZ3OAGbHiFG+Yndit79bG2And15wPWCFozuuKqs9mHlShru6Yr4IIi3
         GZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977153; x=1684569153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6nu6piTr0i1fYr31JjKQwjtY64D+bWACwQlhYUMdwU=;
        b=mGQ6tmxly/9+XYA+asUAnaRc7HpVOjTGwA6EYrf7ORAR+1ar2lC5yz79SK267nWwN+
         fOxuRbiggK9KqP8QOD/j8G5IdiIEvsKIpFe9ZGWnlu5rLea/ljrn5P0An1H+3pnj8VdM
         7KeRk3zz0V1Vc2Wakm1cBSueWbPuEbWDrsolLkxbriQh8m/VvQ1VqGHccM1qwqX7tAVF
         Sj0OhwMrVbtZZcj2DV6VL8aSwMWKrC+YenpnnX5wzPM6eQIgVQWDi0xwcKCG8RJKrDDY
         lRuEr92F8W85G9jjgcGecUZzw/pbzFcLzOh5BTzGT9yXjukKn0wVIN6B/ArjwY02Eb8v
         fg9w==
X-Gm-Message-State: AAQBX9ebB4U5R6jPRFgTKNRSAbnmy3QE3dKmAhIzaRVIyX70EU3RYZtF
        SDopNwf8Ybm67CrL2E2j+PE1rgHQ6lBntWItFsnNNeLVkis=
X-Google-Smtp-Source: AKy350YdLyB5cufExNOan4uji6Sp3DXoHWcw8Mzt8zXMjMvOMOCjlLCyullhTTybU0GiL/A64AOb/XBzBltHbrxUR2o=
X-Received: by 2002:adf:fd11:0:b0:2f5:9e05:1adc with SMTP id
 e17-20020adffd11000000b002f59e051adcmr414563wrr.49.1681977152968; Thu, 20 Apr
 2023 00:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
In-Reply-To: <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Thu, 20 Apr 2023 09:52:22 +0200
Message-ID: <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
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

I made some more experiments and compared the data from the usb_urb
and what tcpdump sees.

The byte order is different in the dumps.

The correct ip packet ends with "92939495" / "95949392". This data is
present in both usb_urbs, but gets cut away in the broken ip packet.
What is the data after "95949392" in the usb_urb? Is this some kind of
footer or checksum? The working packet has a footer of 8 bytes and the
broken only 4 bytes?!?

Working dump:
000005e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
00000600: 85848382 89888786 8d8c8b8a 91908f8e 95949392 e4818dc6
b6a7742b           ........................+t..

Broken dump:
000005e0: 65646362 69686766 6d6c6b6a 71706f6e 75747372 79787776
7d7c7b7a 81807f7e  bcdefghijklmnopqrstuvwxyz{|}~...
00000600: 85848382 89888786 8d8c8b8a 91908f8e 95949392 98ce2927
            ....................')..

tcpdump working:
0x0580:  56575859 5a5b5c5d 5e5f6061 62636465  VWXYZ[\]^_`abcde
0x0590:  66676869 6a6b6c6d 6e6f7071 72737475  fghijklmnopqrstu
0x05a0:  76777879 7a7b7c7d 7e7f8081 82838485  vwxyz{|}~.......
0x05b0:  86878889 8a8b8c8d 8e8f9091 92939495  ................

tcpdump broken:
0x05b0:  86878889 8a8b8c8d 8e8f9091           ............

Thanks, Artem
