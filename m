Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE27155FCF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 21:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGUlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 15:41:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37110 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 15:41:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id c188so399318qkg.4
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m+sFHC1novcEDkb+8bqObLDQeqxE8eT0EVOWGfUp4c=;
        b=kI8cZd0UJzGOAdb/iD93R4UM9gL0YKays2igLWY5Z0LnAscIm/HOGXKNTvTP8Xl29N
         f9IqALs6vH7D+kOH66lBrZLtGh3xvHYphEar+OXOUZjSRhovSuw0MYSsSb6lKxYXPdCi
         zgt2kTn87IljtryZCb6rQTcF11U9l6i6cmkK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m+sFHC1novcEDkb+8bqObLDQeqxE8eT0EVOWGfUp4c=;
        b=VyorfTIJ8xHP9lS3dhBznJ8RAYxtnDdZbrhvXVtY0Sw8s+PGXWgq/hP4DwDgZfw+kX
         Pgre7wx2TEUIyggAo/UxQlTMsq2Gh1fj1MXBH0r2xP7sm0QfZGXOcDLC2O3jQwHwDwlv
         EKT+Wd9U4dKcilcmRt/h+lX/lNVhR/4/FEW6hZW4QmV6mwyLKdHOqMu/R1ERxIRUB3i0
         zuoKDKqb+NGUQFnn3mwIMUnhbqXef3xvjvWrxuk/dZMXm0NrMSMojpe6s9+7wUSGEw9E
         NFfGvebU/YJorOUNJR4jv75okMyS/C3iVDPgGuOGQXJOCrE3LGxjYVHSpFgIk36+a6ne
         VY+w==
X-Gm-Message-State: APjAAAUbEVDHTCBRWmROoAa3Duub+9EH/yLaF9oQ+aGod4eWt73WOR3Z
        eq+cTnYFL4RNds/hn1qmib8vh36+lgY=
X-Google-Smtp-Source: APXvYqy5+Fb2aSWthqGdwhZ/fLZ9vsu3kqEcnXlhzv6jmZ+6j1MpGMl0A9JeR3AvxqxAYm667I8BrQ==
X-Received: by 2002:a37:356:: with SMTP id 83mr703548qkd.409.1581108082740;
        Fri, 07 Feb 2020 12:41:22 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id c79sm1922559qkg.12.2020.02.07.12.41.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 12:41:21 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id w8so388675qts.11
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 12:41:21 -0800 (PST)
X-Received: by 2002:ac8:1851:: with SMTP id n17mr163276qtk.305.1581108080853;
 Fri, 07 Feb 2020 12:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20200204120614.28861-1-yhchuang@realtek.com> <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
 <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
In-Reply-To: <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 7 Feb 2020 12:41:09 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
Message-ID: <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com>
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
To:     Justin Capella <justincapella@gmail.com>
Cc:     Chris Chiu <chiu@endlessm.com>, Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 7, 2020 at 11:41 AM Justin Capella <justincapella@gmail.com> wrote:
> Instead of permanently disabling could a module parameter or other
> configurable be used? I appreciate the performance enhancements but
> don't like the idea of disabling functionality

It feels like you have that backwards: Tony is claiming that
(a) TX AMSDU does not give any performance benefit on 2.4GHz
(b) TX AMSDU gives a severe performance degradation on 2.4GHz with certain APs

That sounds like a case where the feature should be disabled by
default. (A separate module parameter to re-enable it experimentally
sounds like it could be OK, although it's not likely I would use it or
recommend doing so. But that doesn't sound like what you're
suggesting.)

I say "claiming" above, but I have fielded evidence for (b) at least.
I don't know much about (a), but limited tests haven't showed any real
loss for me.

HTH,
Brian
