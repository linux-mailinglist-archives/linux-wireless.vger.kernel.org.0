Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBF18F181
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 10:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCWJOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 05:14:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33459 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbgCWJOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 05:14:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id d22so11043238qtn.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2020 02:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dBRciaDsVIOdEdwsknaEvJP47GsojMZ0FzIE6FHdyo4=;
        b=UzkswjCgRTHJ1nnEFGKX25fu4UAPBniStauHtFIrUE+aXGG4/KEmX4bAeRnqc6GiGI
         ixKH0D5iX9JNP7kHte2qNlugVTOtm8093+oRtjWCyb1VfSn0O4ufSs5w1uBrO/Ogr6A4
         AjzdvPOMOtazIBgKkQafIVCJRyfND5TPHNDjgPD9XRAR3h8V87hywaCU7JIxzODxExDc
         bhyltGzcovcC+xwCPbkKTylM7thnLblllW/74eAFQlOliYWvpf/RPSUpQNt7nTC/lWkn
         1ayVRCQS7C2Nt0KAJaFtA7Y6niwu3Nywuwfihl+3UXw5+oJaMjmUkdkWZ6hkbBckIoYR
         fmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dBRciaDsVIOdEdwsknaEvJP47GsojMZ0FzIE6FHdyo4=;
        b=oZkpVxEn3+lVpIuiis7JUUmgn7xsNF8U2OPjpUdIiK3VKQZTlDvuDO+igDUnzuc1yy
         ZCMW0KRsB3zjqpue09QWKAmOqCknL/N+/zjKUYIjn/Uf+OoD7hC+Vcr7PSUuObBGvvKr
         OrxOV43gGJdR/W9YKRrsvrE81/rCly7cIEiHeQS9w3wR1FTqd6R/JorRH23w3vE29qGb
         teW1WdkY6p0llozE5pH/lhIRxmVxhwNf0xq0OQaJ4rHjGxHfvPZRDHZH4RK9wS5xac9h
         JKWz6VnHuzzqpTOOshd8tfS5Y+Vw3eFFpjgBc5VwH6gqCP6gs//RJ4JarfxRR080U+CK
         k2+Q==
X-Gm-Message-State: ANhLgQ3PXYYrssJwDUSp7pZbc2CCIjG25NtOL9d3crtyDy5gZve9CQfo
        6DLa9EYsxMv/RbTXbSnHNTzhvVcPlg90spai4XU=
X-Google-Smtp-Source: ADFU+vvFAqhwWX/6bzQM0/se9Pt4EIYCWGo68IL5ljc6hPqAjCOI4sta8wdBsHc6A3IKFhLHcPLnJbPFIIUtfUFNLsw=
X-Received: by 2002:ac8:2911:: with SMTP id y17mr8298020qty.73.1584954850246;
 Mon, 23 Mar 2020 02:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
 <CAFb4eQkFGM1rhrccExu6B5_5-3g60nDD_aRt3JDA2qT9FVbDig@mail.gmail.com>
In-Reply-To: <CAFb4eQkFGM1rhrccExu6B5_5-3g60nDD_aRt3JDA2qT9FVbDig@mail.gmail.com>
From:   Equipe Soft <equipe.soft.isere@gmail.com>
Date:   Mon, 23 Mar 2020 10:13:58 +0100
Message-ID: <CAFb4eQmRk8o_sR2-s0h4wUdgNW2w2tqgUjaJ4t0Ca84iZL59fQ@mail.gmail.com>
Subject: Re: Is iwlwifi-9260-th-b0-jf-b0-46.ucode a debug firmware?
To:     linuxwifi@intel.com, linux-wireless@vger.kernel.org,
        Luca Coelho <luciano.coelho@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, we really wonder if the version of the firmware we use is the right =
one.
I put Luca Coelho in copy according to his activity on git about
firmware: thank you for your help Luca.
Best regards.
@team.


Le ven. 13 mars 2020 =C3=A0 11:05, Equipe Soft
<equipe.soft.isere@gmail.com> a =C3=A9crit :
>
> Hello, do you have any news about the issue?
> Best regards.
> @team
> Le ven. 6 mars 2020 =C3=A0 10:33, Equipe Soft <equipe.soft.isere@gmail.co=
m> a =C3=A9crit :
> >
> > Hello,
> > we are using backport-iwlwifi core45 drivers and latest AC9260
> > firmware binary blob:
> > latest firmware available in Intel iwlwifi firmware fork:
> > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.=
git/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=3D4bebf45872a9818a17e207911=
8500030a8fa377a
> > 2019-11-28 iwlwifi: update FWs to core47-142 release
> >
> > At runtime, we noticed these log traces:
> > iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
> > iwlwifi 0000:01:00.0: Found debug configuration: 0
> > iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware monitor.
> > So it seems that it is a debug firmware...
> >
> > Q0) can you please confirm that we can safely use this debug firmware
> > in our product ?
> > Q1) is debug mode deliberately enabled in newer firmware or is it an
> > error (maybe like forgotten to disable it) ?
> > Q2) is there an impact on performance with this debug firmware ? WiFi
> > speed/throughput may be reduced or not ?
> > Q3) moreover, can you please confirm whether or not WoWLAN (aka
> > Wake-on-WLAN) is working with this debug firmware ?
> > Q4) is WoWLAN working with any AC9260 firmware version ? and any
> > iwlwifi driver version ?
> >
> > Thanks for your help,
> >
> > @team
