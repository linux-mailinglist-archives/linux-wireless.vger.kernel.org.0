Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22BB10EF85
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLBSs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 13:48:59 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:41881 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLBSs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 13:48:58 -0500
Received: by mail-il1-f171.google.com with SMTP id q15so635645ils.8
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJ+m0mSzIeOb5sZruqACdh0sGgA9QWLB1HsmrayP9B4=;
        b=Of7gE+DwkR5XuGo8buT3QWoDgHM8egXbttQebXtPXHv6nKdCiqBk+K49zrUDTWhM13
         Sm/5Bc9HspVWUQrABojD2VPLtBc0AgOiF9cCQNSnJHpE4GYKNy0XEY4yjzCm4wfel4tN
         UtS2KOxSd/dWLxFZPCCkP3hEmjiChfx9egTaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJ+m0mSzIeOb5sZruqACdh0sGgA9QWLB1HsmrayP9B4=;
        b=gG2VTtzZLix5TkZdnKzehHUIcuoEY08vtRBJf7Fc1knLfqVq8sBe7gYsVmlWdPVwSk
         tPXd+zRCxw2KfO02RyCSWXVcALavXqLf1FXifEsev73165+5pjrrzaH4rTh0jc+woSdP
         szABnJ/x50TyLGAq/gGgVHT1cCfR4tNw+Y9yZdNKc1cC6aniygbws5j/YqHX1rMrGSiv
         pkPbeO0TqNFAfX03b7T6MZ0Co4hBO+UmGjnUWUOeL1H9dlidHc46bwbw++qBNoHNSDrc
         71A+X7IMmuv2CJQKNE3aVIR6BQTuBNN2S7r5rYActo8iHuDa5E+yi2+CVkL97NULyPhQ
         y0ZQ==
X-Gm-Message-State: APjAAAWq4emD+aPY/xFKCD3VSglslmOieZcFWYjeTET0EdqbghEkpmX6
        mZoDC43t1Kl6ClJHK/VVuvRqxjcfEj8=
X-Google-Smtp-Source: APXvYqzCIVkwKGBbGfJ494AKHS1cOfNNW1zsgA7GD+rOXs+dIj9S7eOUEHmXde3TT8ygP0Q473VatQ==
X-Received: by 2002:a92:3d49:: with SMTP id k70mr204506ila.246.1575312537818;
        Mon, 02 Dec 2019 10:48:57 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id b15sm63305ilo.37.2019.12.02.10.48.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 10:48:55 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id w13so679268ilo.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Dec 2019 10:48:55 -0800 (PST)
X-Received: by 2002:a92:d18a:: with SMTP id z10mr263197ilz.48.1575312535313;
 Mon, 02 Dec 2019 10:48:55 -0800 (PST)
MIME-Version: 1.0
References: <1542163848-837-1-git-send-email-wgong@codeaurora.org>
 <20181115002836.GA71934@google.com> <c94346b26a6d4b11a045a176ca854051@aptaiexm02f.ap.qualcomm.com>
 <20181115184333.GA87504@google.com> <87va4x8q2c.fsf@codeaurora.org>
 <CABvG-CVAnwkiKVJik0PdsmRxF62kKv2N+aRKNq=nbopoExLvDA@mail.gmail.com>
 <87y36q75wr.fsf@kamboji.qca.qualcomm.com> <CA+ASDXO8NujrORVLZMPbDy916cnzOvx_Bp8Vr-VvkbBwJvB97A@mail.gmail.com>
 <87h8cd8zy2.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87h8cd8zy2.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 2 Dec 2019 10:48:44 -0800
X-Gmail-Original-Message-ID: <CA+ASDXM8gtn3=p5pQ=GOFdfTy-698ZPW91JEgAfapdLEcU+eMg@mail.gmail.com>
Message-ID: <CA+ASDXM8gtn3=p5pQ=GOFdfTy-698ZPW91JEgAfapdLEcU+eMg@mail.gmail.com>
Subject: Re: [PATCH] ath10k: support PCIe enter L1 state
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     =?UTF-8?Q?Micha=C5=82_Kazior?= <kazikcz@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k@lists.infradead.org, Wen Gong <wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 8, 2019 at 1:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Brian Norris <briannorris@chromium.org> writes:
> > On Fri, Feb 8, 2019 at 5:42 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >> No replies from anyone (including Wen) for 3 months about testing this
> >> patch on anything else than QCA6174. So I'll drop this now, please
> >> resubmit once test coverage is better.
> >
> > I know this isn't exactly what you're asking for, but FWIW we've been
> > using this since late November on all our QCA6174 products. No issues
> > seen as far as I know, and we have seen some power savings.
>
> Thanks for the feedback, this is very good to know. I also would like to
> apply this but not before we have some testing feedback from AP chipsets
> like QCA988X or QCA9984. Wen, are you planning to test those and
> resubmit?

May I ping here? We (Chromium OS) are continuing to carry this patch,
and would love to come up with something that can land upstream. If
necessary, I can rework it to apply more specifically -- e.g., only to
QCA6174 PCI IDs.

Thanks,
Brian
