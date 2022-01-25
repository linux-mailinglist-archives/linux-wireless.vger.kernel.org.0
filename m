Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB29549BF30
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jan 2022 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiAYW4m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 17:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbiAYW4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 17:56:22 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99DC06161C
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 14:56:22 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id s12so26385765qkg.6
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pf4LR+HDgvHIgHs+Dc3VVimHBG2P1oSVQMMzXRhSFfk=;
        b=c2zcrOSB1bTbgyIHCAJPILY6NaYxmiGcCwUE3NmQETnDwArM5okFr5Lk2kiTf2gPjO
         4TqUCEKSRIgyjMOuetA96SvmGhYTR5syonHlsem1uTKCCaFct3Y1TItCl8Z2VpwGXRkQ
         GEIcKjOEdW/n0lX0XAQGlxvEbkbJ9HTCHulVKzNWpVE6g4izgOBcoR+DSwGHxe4AvQEZ
         ot28HZtL0omM3M7a4U1MRXpj5x9tmhuENqhPl2g3Kx9lCG7McAqEPe0TrLadbsMVbfR1
         5Xjnd54Pv2iradDTkWCRFpKjuI5XCJ02l39ytm5Bf6sbhVqGdlLUTCZXexHmwPaLP9dK
         dGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pf4LR+HDgvHIgHs+Dc3VVimHBG2P1oSVQMMzXRhSFfk=;
        b=S+3v7NXrVyTHCvAUGizcXIidDLLwm0Jfs+OsRuMEdRyGrShVYcAV3VxcAJBssaeh3n
         1PuPIbMT/d6JK/CHahkoEHvnfv/oVt9loaKlV4AujNBpopSGSGW+vVnHbK11N9Kw/X8w
         mNEy+vB+bZpGrzU8Rvcs/URM1ofA0CpdVcYR6eqRrZvt9KDxIdP/hq284aKmtQt6rUG7
         aJyxVK5sJpwrrT3jEEpwhkDy+d+EWwWhtZsYXxvUfUbZav1gsp2g/rQpRr0RaHxtDx4t
         wlsCN2SWWijxc5OX4KtbfFyF80rivDa4PJb5oZRnLWq6cn5Zx8EX/RXolf21NhMnyuTR
         blNA==
X-Gm-Message-State: AOAM533Ij3knsl7UwST/ae2WWQa7kR4ree51JkuLs6kOj1XCAAYrm38z
        kg5pZlAVmEyWaFILZbsThBD6lYNr2uG67k2r7MRuqw==
X-Google-Smtp-Source: ABdhPJzYCRABMILMdvnImlA6uWbmy9/uIfcZnkSjHLGihwT8hih69vZKJaKD38KnSfGsx+phAj3VPUqfKlH28/Cp8PQ=
X-Received: by 2002:a37:9c4f:: with SMTP id f76mr7000304qke.464.1643151381712;
 Tue, 25 Jan 2022 14:56:21 -0800 (PST)
MIME-Version: 1.0
References: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
 <20220120095622.1938-1-mike@fireburn.co.uk> <CAHbf0-HLCcgZfbKdWQ-kX+QbRGJsEHCEDnG=NZ5QF71aTeDMGg@mail.gmail.com>
 <9d692dc9-4b24-44b0-cbe0-dfc33f3d5f03@candelatech.com>
In-Reply-To: <9d692dc9-4b24-44b0-cbe0-dfc33f3d5f03@candelatech.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 25 Jan 2022 22:56:10 +0000
Message-ID: <CAHbf0-FwH-ftCFeqrNusu4DBPrKe0SeTAQnAZngpsn+At-fJsQ@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
To:     Ben Greear <greearb@candelatech.com>
Cc:     khalid@gonehiking.org, Deren.Wu@mediatek.com,
        Eddie.Chen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Eric.Liang@mediatek.com, Leon.Yen@mediatek.com,
        Mark-YW.Chen@mediatek.com, Soul.Huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        YN.Chen@mediatek.com, abhishekpandit@google.com,
        ch.yeh@mediatek.com, frankgor@google.com, jemele@google.com,
        jenhao.yang@mediatek.com, jsiuda@google.com, km.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name, posh.sun@mediatek.com,
        robin.chiu@mediatek.com, sean.wang@mediatek.com,
        shawnku@google.com, steve.lee@mediatek.com, ted.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 25 Jan 2022 at 18:09, Ben Greear <greearb@candelatech.com> wrote:
>
> On 1/25/22 6:16 AM, Mike Lothian wrote:
> > On Thu, 20 Jan 2022 at 09:56, Mike Lothian <mike@fireburn.co.uk> wrote:
> >>
> >> Hi
> >>
> >> I get a BUG and the kernel resuses to boot with this patch when mt76 is compiled into the kernel
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=214557
> >>
> >> I don't see this issue when mt76 is compiled as a module
> >>
> >> My .config is at https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
> >>
> >> Let me know if you'd like any more info
> >>
> >> Cheers
> >>
> >> Mike
> >
> > The bug I was hitting was due to a different change introduced in rc1,
> > with that reverted your patches work great
>
> What patch did you revert?
>
> Thanks,
> Ben
>

Hi

I reverted both 730b49aac426e1e8016d3c2dd6b407e500423821 and
510a0bdb2bfcff8d7be822c72adc3add7a97d559

But there's a fix now,
https://patchwork.kernel.org/project/linux-usb/patch/20220124090228.41396-2-heikki.krogerus@linux.intel.com/

I'm able to load mt76 as a module or built in

Cheers

Mike
