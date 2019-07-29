Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E73795C1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbfG2Tpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 15:45:43 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40500 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389988AbfG2Tpm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 15:45:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id b17so42930770lff.7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Xj0KmdFEesb0An0pvpoI4nRdiLfdj9xAiXwnPK4NLM=;
        b=i4fDxC9jgwYfkwAabdzbHKdotQBa5S7C9sw2mTATq9cGBTlThSmyjKilRde22eS4EQ
         J1y54uKk3TdvfFz+IZixYBhYEDQKK00Yr5LCyxsLkgEpzD2QrreBz4/IrMb+XjkyZi4f
         6P+ywrpTxBuWukUHucrzU54+yZN5I364s2E6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Xj0KmdFEesb0An0pvpoI4nRdiLfdj9xAiXwnPK4NLM=;
        b=js+zS+rfJBEFjoyVvudgVlie1sd3u+nWdQCwIl1ZD9XTFv0hWhKLKFc4WoVMsap8pz
         1SD9Pb0xhc54HjuZ2h5yiP3WARBQ6UmBKEnPPHCRDpjbm3EvAZNx/XkqAKqi00+vtOXV
         rRIqTP2OkEOcLBI6I/PIlXIgexjLIVFF5zg/Q1VM4xzIE/RIHmGioVb3l+IqIkz8LrCk
         Lzf+/dg+DgthGGEGmjGs2w+8/IANbgUK+OLfTaJ1zv6HbQgBt8CIXmQfuw063gmoh19Y
         SJaYjRE3n37SWMmBnCiRoBV9nnWqMEdYiIFgZ9hbLxH2SZzVj6CrhRO0Bp7NIFwwQSeD
         oM8A==
X-Gm-Message-State: APjAAAWngpqJwbEUE4d5TkKqqG4WNtzRb5M/NAv9lRajpTcr9JE/m+d3
        Ita84Raa/i0wmxqP6jesRuqTDck2jGc=
X-Google-Smtp-Source: APXvYqwj3T94G6Y6fMOQHc5PkynTMRjnaRLh+OT/z7+74jie+9pLY/08qGcst4OOFE2NbtQnuyrddw==
X-Received: by 2002:a19:4f4a:: with SMTP id a10mr52206216lfk.30.1564429540177;
        Mon, 29 Jul 2019 12:45:40 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v2sm10800839lfi.3.2019.07.29.12.45.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z28so5497861ljn.4
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
X-Received: by 2002:a2e:3602:: with SMTP id d2mr407913lja.112.1564429538156;
 Mon, 29 Jul 2019 12:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190724194634.205718-1-briannorris@chromium.org> <s5hv9vkx21i.wl-tiwai@suse.de>
In-Reply-To: <s5hv9vkx21i.wl-tiwai@suse.de>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 29 Jul 2019 12:45:26 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMEFew2Sg5G1ofKq-0gfOTFEOhZNjfyNJMRzRjv7ZFgXw@mail.gmail.com>
Message-ID: <CA+ASDXMEFew2Sg5G1ofKq-0gfOTFEOhZNjfyNJMRzRjv7ZFgXw@mail.gmail.com>
Subject: Re: [PATCH 5.3] mwifiex: fix 802.11n/WPA detection
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        stable <stable@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 29, 2019 at 9:01 AM Takashi Iwai <tiwai@suse.de> wrote:
> This isn't seen in linux-next yet.

Apparently not.

> Still pending review?

I guess? Probably mostly pending maintainer attention.

Also, Johannes already had noticed (and privately messaged me): this
patch took a while to show up on the linux-wireless Patchwork
instance. So the first review (from Guenter Roeck) and my extra reply
noting the -stable regression didn't make it to Patchwork:

https://patchwork.kernel.org/patch/11057585/

> In anyway,
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks. Hopefully Kalle can pick it up.

Brian
