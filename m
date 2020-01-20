Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30219142EDB
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2020 16:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgATPhw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Jan 2020 10:37:52 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34849 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgATPhv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Jan 2020 10:37:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id i15so129512oto.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2020 07:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+zkONziERjkHD7k3oYFXBXc05D/2+MxZQ4nSI7z3qk=;
        b=AHd+J4/3/7JacS9+SI6MIPMtosg9dAAmykNTi8KMxtIQ/ZKUIYvJo19iydRznddI57
         eDmxdC+hBiCQ6DIes+yUW0kYfOAdQ69Arcvkh6O4StLJodJlljGhuLN0Inz+svml6jDY
         CdioQy0uTCh3i4MhfiCdoa2CCfHAT0AZpFDozghLrxgWdKegz3UVFGnSu2oMvjKYQWkH
         Q6hmyoyFGoEH8rhud76+orkFhzwgOo60dO8rHe6OUtjw2X8fXnukWqSWC6V4jGNTBbTW
         DNAjx/2jql2pLB4K/bJjFhPQx6Cwf1Nw4ypkjFUwVbV2zjgKato26yoW7SrYVspoD5UL
         M0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+zkONziERjkHD7k3oYFXBXc05D/2+MxZQ4nSI7z3qk=;
        b=mp+AL0J5n6Y7EmqVHAn2SLAAXIkcvDDymBcgEuXIhz2/CSizSKxVYgcY+4BEW9Z/es
         UcE9rOiswnFw08GMhmoOg/CbtSPkWKcTcSUG8utcud9b77eIsHTJQd6UWe1wHsabki1X
         4T3YrsAfTr33Cs4nRKC387bBWU46hbrJwWp69bkI7Z8NRaIrY9coKpts/IoDmnCqE+39
         oBCpz7jKdmYdqBfB0yz1pZ9HgKOcfe+OScAAgyuJXE6CCHFKHVv4l2DSLGX8I5SmElWB
         sspvJkQbhuiw2MOfWJIKbfAY5V0x8Y4c2UNjYgZS3/MIvHZ3LefRefVfFTIN/3FWXO/F
         aJbQ==
X-Gm-Message-State: APjAAAW/fJQw2VyJcGgiyYyDfLEYtESYPxOxjcSJ+IroDnjGyiHvsbyy
        OWolhmuucFCtx3eMZn2IDRqjhPBV2hEP0Jgs51E=
X-Google-Smtp-Source: APXvYqwu5mz6B9vSsztKWgBDqwfEReavjCw3dBtvZ76trPgreHoSv7P0QzJSKSAbE5ouumLLtljuV3VJuM1vF6PNTkI=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr15658844otp.177.1579534671064;
 Mon, 20 Jan 2020 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200108031957.22308-1-wgong@codeaurora.org> <20200108031957.22308-2-wgong@codeaurora.org>
 <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
 <55ab2d64e78d51a9da587f276899e08b@codeaurora.org> <a1950ee2cb8dd9fc10e7d31bf18c9c95@codeaurora.org>
 <CAMrEMU8DmXBGGU-WNd9bQAVVkHF6SCO7c_wv+dyH9D7KFOB8jw@mail.gmail.com> <7ad4db8ea256a823778edf89b2a1b2fc@codeaurora.org>
In-Reply-To: <7ad4db8ea256a823778edf89b2a1b2fc@codeaurora.org>
From:   Justin Capella <justincapella@gmail.com>
Date:   Mon, 20 Jan 2020 07:37:39 -0800
Message-ID: <CAMrEMU98aMAfJdxECYPfLgqLC-zp1rA4K+DkWz=v3bTehMaoiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sorry, that response was intended for the start retries.

On Mon, Jan 20, 2020 at 5:34 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-01-20 17:38, Justin Capella wrote:
> > Ok thanks. I am still trying to familiarize myself with ath10k. A
> > couple things come to mind:
> >
> > firstly recently there was a patch that set stations back to
> > associated during recovery, do you know if the branch you're working
> > against includes that? I will try to figure that out myself but it's
> > at least worth considering.
> >
> can you give the patch link or patch?
>
> > If I remember correctly, the sdio rx involves peeking and checking to
> > see if the frame/packet continues/has more. In the case of firmware
> > recovery/reconfig I think current code enables all sorts of debug
> > pktlog stuff, historically it was maybe used as a hack to check for hw
> > changes... But I mention it because I think what might be happening in
> > some cases is fw crash follows a frame that would continue/extend,
> > which is messing with the content and act_len (maybe?)
> does it have relation with this patch?
> >
> > I also noticed that with aggregation I wind up getting a
> > deauth/dissasoc followed by mlme delete sta/peer/key.
> >
> does it have relation with this patch?
> > I think a retry count could be useful but what do you think of maybe
> > using an event / timeout?
> >
> does it have relation with this patch?
>
> >
> >
