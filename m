Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9C4C3248
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 17:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiBXQzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiBXQzf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 11:55:35 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD4817060
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 08:55:03 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id d3so4657239qvb.5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXPNnlAjhOiDJLg5gbjFBgF6ssyzfnV2Q6Fjv6GQF4I=;
        b=FFhunHPCX/w1efnWA6Xn0Ym4Wu8MZm/FdB0T6fyxQsqryu1NePmOzHoskTl3v6uk+W
         aFkytUzNkY3JeUWoU/U3nU9QO7aXc4qQjQVYcpqegPqwmXmog8HLQJirw4EizcKofdsv
         nVS1Do9o4jArL5QzyfeEbipscmSr2/ed/lzw+qes90qLHLO7FJirTTCNAOybRsJSTc6M
         NajOSu7gBx5D3FIpbs0AOdlBSgPZpRFXK3EZw/YPxEDcbqnaYNbx6YexBS3wJktZEF9a
         QHcc5xpmr6fGwlSlrCEd9LCTaRUUQv0d0moX04Qme5asZkMGGrqOagEcZtqTUwzJvcXd
         za/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXPNnlAjhOiDJLg5gbjFBgF6ssyzfnV2Q6Fjv6GQF4I=;
        b=p2qop+Ti9Q2MvZpbW+Papi48Gb2xJvY615aRD4yoH2rkI/OfiXEThihTGaYS8dUkjr
         Op95nOHBxsSzWjh+OW0V3/c+OtN87R7t4RAeA6Hz0PkuY1/3mvVo0hqwvZx5HoC7rwpK
         JzktAtIvGrTbvJGe2ublCD6JB+LadTSgMoXEuMYOMODg1V9GwyhYDaOBMEcXMKrd44sR
         fZS++u6Ph/WWul2wnAfHjFZGJhg9tSMhVVSs0cqd5zneplvz97RENyBUcUgWXTUPcFNt
         8VdE1iUEUV1cxCeBynHeBNfQambq6Y+PpGQSNyDxiNmSk+lx2AON+GBqHjhS1h5mvCb8
         CTOw==
X-Gm-Message-State: AOAM532h5ECBE7SuXavKffftuEhMrm9jdUg2aYYjLhl75ikLUhbUBsB6
        L4w7gIEf8HE2fowH3DPt6WGyylPoZO5Q8ZzucgHqKg==
X-Google-Smtp-Source: ABdhPJxJQqF2+HRYwSLNa/lBytL/zXGwgoRRaxkZ7CaYqfS5JtatQ3Woh9tqksMdrNZCkLQl2GTJBf4gfdp9YQvzxho=
X-Received: by 2002:a0c:a994:0:b0:432:9b1b:f815 with SMTP id
 a20-20020a0ca994000000b004329b1bf815mr2135081qvb.42.1645721702203; Thu, 24
 Feb 2022 08:55:02 -0800 (PST)
MIME-Version: 1.0
References: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
 <20220120095622.1938-1-mike@fireburn.co.uk> <CAHbf0-HLCcgZfbKdWQ-kX+QbRGJsEHCEDnG=NZ5QF71aTeDMGg@mail.gmail.com>
 <9d692dc9-4b24-44b0-cbe0-dfc33f3d5f03@candelatech.com> <CAHbf0-FwH-ftCFeqrNusu4DBPrKe0SeTAQnAZngpsn+At-fJsQ@mail.gmail.com>
In-Reply-To: <CAHbf0-FwH-ftCFeqrNusu4DBPrKe0SeTAQnAZngpsn+At-fJsQ@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Thu, 24 Feb 2022 16:54:51 +0000
Message-ID: <CAHbf0-E6TOfwNOVWDxgaU4D4D1dFPwHK8h_k5AfuxJkaQvDcVg@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Has this patch made it into any upstream trees and is it likely to be
backported?

Cheers

Mike

On Tue, 25 Jan 2022 at 22:56, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> On Tue, 25 Jan 2022 at 18:09, Ben Greear <greearb@candelatech.com> wrote:
> >
> > On 1/25/22 6:16 AM, Mike Lothian wrote:
> > > On Thu, 20 Jan 2022 at 09:56, Mike Lothian <mike@fireburn.co.uk> wrote:
> > >>
> > >> Hi
> > >>
> > >> I get a BUG and the kernel resuses to boot with this patch when mt76 is compiled into the kernel
> > >>
> > >> https://bugzilla.kernel.org/show_bug.cgi?id=214557
> > >>
> > >> I don't see this issue when mt76 is compiled as a module
> > >>
> > >> My .config is at https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip
> > >>
> > >> Let me know if you'd like any more info
> > >>
> > >> Cheers
> > >>
> > >> Mike
> > >
> > > The bug I was hitting was due to a different change introduced in rc1,
> > > with that reverted your patches work great
> >
> > What patch did you revert?
> >
> > Thanks,
> > Ben
> >
>
> Hi
>
> I reverted both 730b49aac426e1e8016d3c2dd6b407e500423821 and
> 510a0bdb2bfcff8d7be822c72adc3add7a97d559
>
> But there's a fix now,
> https://patchwork.kernel.org/project/linux-usb/patch/20220124090228.41396-2-heikki.krogerus@linux.intel.com/
>
> I'm able to load mt76 as a module or built in
>
> Cheers
>
> Mike
