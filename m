Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4919D16C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2020 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgDCHmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 03:42:55 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42177 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCHmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 03:42:54 -0400
Received: by mail-qk1-f193.google.com with SMTP id 139so7042539qkd.9
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2020 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qFaIqoxwUe9ysWNEdvZGpWkJArIzzp/tfUXLdH5gS64=;
        b=KcG564o4naeszHPQaCUG43TLopoLHQcXNhy55ihf4J655P1X1EX2er+7j98/34GC3H
         yxGA4jHLR9t/ysr+9MFg7AFVOVSODpPoUZMysTDJDoTljG+COLNwQDyC9opauJPkGeRH
         oaNjwl6yhnT2u4S/B54XjZRB1v1D8sXS1W3BL/GB7oO0yEYpR5571pe/h5pD02wsWkNw
         3ekuRKXOXG20oha+a9fMG9Bp5qCI3rpJCdJyVjk1hOjKV7hcYSB0P1WSFtQjB7ctuAYN
         JEkuSjE8Pf3dOu5lyeM743GMe2WJ0ZZAODO0uyL1sKm7zZ2ce8PIS2LpnzKPNoaDw2rK
         AOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qFaIqoxwUe9ysWNEdvZGpWkJArIzzp/tfUXLdH5gS64=;
        b=OGl2y+fLS8/bpEWo26Eas8AUDN+kQfBHYdP90EFeYYHKaTO200OmbU91nl1ryD3K8Z
         F7lRr+nBgcxcXsBCJ9t69tcchctf+NM3oSPzYRs/BEGXD1O/6/e5QImp1Lj6wSmVJn3d
         TVf8Px09bAwdCYk7CwcWY2ApiW3c+HhxSo1daSMJk91xIXmvvebY6b7LXbOw4MtGYNGR
         uIOEzDUWAkkHL79gZ7ynfmQX7PStFMuw6HjOHzto2Qrtdv1vlcMijWz+778btW55pAUQ
         EKZVFka4fj7N15ihhxC7bLiJsUpPzz7DMGvXewjswIikanLB8Xk61DbEEW9+Lg0R2YLd
         rfUA==
X-Gm-Message-State: AGi0PubxFo+qu2Y+afjoBaLL2jwZ/dsD4Q9vryyaIpV06FlFnd8i5IzI
        jzGAAFescNfkLX+YkZVO2hBJ/K/3QdLmAcranxc=
X-Google-Smtp-Source: APiQypIoVU87l/ofPpIn/O8uJ2m6m/NguBlqBffg5PpVqRfayjzuHxv0pcVYqXHTezaieYgM8Hb4AF9JkGPpfzE6c0w=
X-Received: by 2002:a37:634d:: with SMTP id x74mr7584637qkb.254.1585899772041;
 Fri, 03 Apr 2020 00:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFb4eQ=Y8XUGsE2c2tur4EPTC=81Ck3tRPF9Uf+6zBnA47j-Dw@mail.gmail.com>
 <CAFb4eQkFGM1rhrccExu6B5_5-3g60nDD_aRt3JDA2qT9FVbDig@mail.gmail.com>
 <CAFb4eQmRk8o_sR2-s0h4wUdgNW2w2tqgUjaJ4t0Ca84iZL59fQ@mail.gmail.com>
 <3abf2b162f18e41345e230301d57348ba348c09f.camel@intel.com>
 <CAFb4eQ=jTrt42a43bhfN02BtqrTmJe7HUmcDPZnxjqXztp6cxA@mail.gmail.com> <CAFb4eQkp_cCCPd6sU0jLhRnasjVSU8DGMUMudV28ZRm14HtUeg@mail.gmail.com>
In-Reply-To: <CAFb4eQkp_cCCPd6sU0jLhRnasjVSU8DGMUMudV28ZRm14HtUeg@mail.gmail.com>
From:   Equipe Soft <equipe.soft.isere@gmail.com>
Date:   Fri, 3 Apr 2020 09:42:40 +0200
Message-ID: <CAFb4eQnSAQUCyonaRgnFbi0=GAzSKsCjKCm41cx77=r7dnxyMg@mail.gmail.com>
Subject: Re: Is iwlwifi-9260-th-b0-jf-b0-46.ucode a debug firmware?
To:     Luciano Coelho <luciano.coelho@intel.com>
Cc:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi there, did you had time to look at this issue? Thanks again.
>
> @team
>
> Le mar. 24 mars 2020 =C3=A0 11:50, Equipe Soft <equipe.soft.isere@gmail.c=
om> a =C3=A9crit :
>>
>> Thanks a lot Luciano for your answer.
>> However something remains a bit strange to me. So let me please ask you =
the following questions:
>>
>> Q5) is it normal that Intel AC9260 firmware size is quite different betw=
een "older" and "newer" versions ?  For example: API46, which includes debu=
g information, is ~1.4MB whereas API38, without debug info, is ~2.5MB (so b=
igger !?)
>>
>> Looking at https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/cor=
e_release#core_release, I get: "Core43 Last version for 9260 and 9000"
>> Looking at https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/cor=
e_release#devices_not_maintained_in_mainline, I get : " 9260 (Core43)"
>> But looking at https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/l=
inux-firmware.git/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=3D4bebf45872a=
9818a17e2079118500030a8fa377a, I see: " iwlwifi: update FWs to core47-142 r=
elease"
>>
>> Q6) so previous wiki page says that we shall use driver Core43 release b=
ut we can notice that Intel AC9260 firmware is still updated for Core47 . S=
o which driver version should be used ?
>>
>> Thanks again for your answer.
>> Best regards.
>> @team
>>
>>
>> Le lun. 23 mars 2020 =C3=A0 10:30, Luciano Coelho <luciano.coelho@intel.=
com> a =C3=A9crit :
>>>
>>> Hi,
>>>
>>> On Mon, 2020-03-23 at 10:13 +0100, Equipe Soft wrote:
>>> > Hello, we really wonder if the version of the firmware we use is the =
right one.
>>> > I put Luca Coelho in copy according to his activity on git about
>>> > firmware: thank you for your help Luca.
>>> > Best regards.
>>> > @team.
>>> >
>>> >
>>> > Le ven. 13 mars 2020 =C3=A0 11:05, Equipe Soft
>>> > <equipe.soft.isere@gmail.com> a =C3=A9crit :
>>> > > Hello, do you have any news about the issue?
>>> > > Best regards.
>>> > > @team
>>> > > Le ven. 6 mars 2020 =C3=A0 10:33, Equipe Soft <equipe.soft.isere@gm=
ail.com> a =C3=A9crit :
>>> > > > Hello,
>>> > > > we are using backport-iwlwifi core45 drivers and latest AC9260
>>> > > > firmware binary blob:
>>> > > > latest firmware available in Intel iwlwifi firmware fork:
>>> > > > https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-fir=
mware.git/commit/iwlwifi-9260-th-b0-jf-b0-46.ucode?id=3D4bebf45872a9818a17e=
2079118500030a8fa377a
>>> > > > 2019-11-28 iwlwifi: update FWs to core47-142 release
>>> > > >
>>> > > > At runtime, we noticed these log traces:
>>> > > > iwlwifi 0000:01:00.0: Found debug destination: EXTERNAL_DRAM
>>> > > > iwlwifi 0000:01:00.0: Found debug configuration: 0
>>> > > > iwlwifi 0000:01:00.0: Allocated 0x00400000 bytes for firmware mon=
itor.
>>> > > > So it seems that it is a debug firmware...
>>> > > >
>>> > > > Q0) can you please confirm that we can safely use this debug firm=
ware
>>> > > > in our product ?
>>>
>>> You can use this firmware.  It's a production firmware and not a
>>> debugging version.
>>>
>>>
>>> > > > Q1) is debug mode deliberately enabled in newer firmware or is it=
 an
>>> > > > error (maybe like forgotten to disable it) ?
>>>
>>> It is deliberately enabled.  We enable some debugging options by
>>> default so they can be extracted if needed.
>>>
>>>
>>> > > > Q2) is there an impact on performance with this debug firmware ? =
WiFi
>>> > > > speed/throughput may be reduced or not ?
>>>
>>> No, there isn't any impact on performance.
>>>
>>>
>>> > > > Q3) moreover, can you please confirm whether or not WoWLAN (aka
>>> > > > Wake-on-WLAN) is working with this debug firmware ?
>>>
>>> WoWLAN should work fine with this firmware.
>>>
>>>
>>>
>>> > > > Q4) is WoWLAN working with any AC9260 firmware version ? and any
>>> > > > iwlwifi driver version ?
>>>
>>> It has been supported for many years now.  AC9260 got support for this
>>> from the first version of the driver/FW that were publicly released.
>>>
>>> HTH.
>>>
>>> --
>>> Cheers,
>>> Luca.
>>>
