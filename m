Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88737FF9F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 23:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhEMVKS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 May 2021 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEMVKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 May 2021 17:10:17 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D226C061574
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 14:09:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so11346778otc.6
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuUVc+1Gl3iIMPO5R1BBEz+t2k66T/LegE8x91I0Gyo=;
        b=MjtIaP2wvTeRYdgQ1Gs8+IDchcxKLvy7E6G2XGtqFfPq97cOecV+h0JvW/VNoPKvjw
         J2xRB+J/L+PELAEN2xaczYu2tlDe/FKQONEWN77Ret1EN+1awO39Fp7HeiU0ZcnTDKTA
         tg9KM4QX9NNno94xte6GDONQSpnUhSAgIyh4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuUVc+1Gl3iIMPO5R1BBEz+t2k66T/LegE8x91I0Gyo=;
        b=WRm+IhKpePIUTC/lxLC1Dx9ltIj0BrYvGofMYMooey4K2y5J6LVtq3MiKGoObOJI7c
         zPc8ZdnswCQXp7Fz/X8810ExRs1vyykfF0lNydl8+IVN9c8rFkYDUy6YCqFK1nysE2f9
         VegHIxerKzGbMKvLrWqKSWFf7TO3AL7xbxmgV/ip1ZbXl6VtQF7C16DavjeT7kGrRdGe
         vJV+1ri7poc3oHqcRo9r9C558/hsTL0qu+QrlLmahTyRdCpY0LBuMgh1mVwfDhZVQbxi
         wUwrK6TyLotdVicpwht+S3vnvoDkKLL32Y6Btg3rGVzvCL1Q04aoacvD4ku3xL46AwMO
         tfeA==
X-Gm-Message-State: AOAM533IRfIahG9QE9o3iN6uFwjRv9cg+V8yuF7672cQvBaNXzuXzzkx
        d+XQ2I+AKYtEJGHcZsxgeLv0KhuehyAeDg==
X-Google-Smtp-Source: ABdhPJzu1tNacG4QUQU0f9BjxNKvdWcX+sN5twG0ESCFC1W2qxyofjIYuztA1PEB/GswJlmS93mGlw==
X-Received: by 2002:a05:6830:445:: with SMTP id d5mr3993060otc.331.1620940146420;
        Thu, 13 May 2021 14:09:06 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id o4sm814766oia.36.2021.05.13.14.09.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 14:09:04 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so24789253oth.5
        for <linux-wireless@vger.kernel.org>; Thu, 13 May 2021 14:09:04 -0700 (PDT)
X-Received: by 2002:a9d:f66:: with SMTP id 93mr36813659ott.229.1620940143875;
 Thu, 13 May 2021 14:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <57e9f582340545c79a9ab3433e2a4a7d@realtek.com> <87cztx87tr.fsf@tynnyri.adurom.net>
 <CA+ASDXM9YmhMWmttkrCxB0_tf6Kf6Sz=7Yc26CmjZmMUxyxAfw@mail.gmail.com>
 <87tun7i2rn.fsf@codeaurora.org> <876c29841fcf4d21ab2440cbb5879de2@realtek.com>
In-Reply-To: <876c29841fcf4d21ab2440cbb5879de2@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 13 May 2021 14:08:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMN__j0x5hN5t98C4k+upOcs+T1=MrivCbxRYa_-ENt_A@mail.gmail.com>
Message-ID: <CA+ASDXMN__j0x5hN5t98C4k+upOcs+T1=MrivCbxRYa_-ENt_A@mail.gmail.com>
Subject: Re: Request to update 8852a firmware of rtw89 to v0.13.8.0
To:     Pkshih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 13, 2021 at 2:38 AM Pkshih <pkshih@realtek.com> wrote:
> > -----Original Message-----
> > From: kvalo=codeaurora.org@mg.codeaurora.org [mailto:kvalo=codeaurora.org@mg.codeaurora.org] On
> > Behalf Of Kalle Valo

> > It can create confusion to the users if during review we make changes
> > how firmware files are handled. Some drivers have windows style .ini
> > files which are not ok in an upstream driver, there could be changes in
> > the file format etc.

Sure, good point. I figured if there's no driver merged anywhere
upstream, people (e.g., me) are taking their own life in their hands
trying to utilize arbitrary versions from the mailing list. But I
could see why you still don't want the potential mismatch.

> > But I have no strong opinion here, my main motivation is just to try to
> > keep things simple for maintaining the "interface" between
> > linux-firmware and kernel wireless drivers. My preference is that the
> > firmware files are ready for submission when a new driver is submitted
> > for review, but the firmware files are submitted only after the driver
> > is accepted.

Ack, that's definitely important to me. The first versions had no
publicly posted firmware, and at least one person (not me at the time)
asked for it. My extension of that is that I don't want to
_discourage_ vendors posting their firmware to public repos :)

> I think I can maintain the firmware in GitHub before driver is accepted,
> and add some information about firmware version and link in the cover of
> patchset. Then, people can take proper firmware.

Sure, that can work.

Thanks,
Brian
