Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7584E2D805B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 22:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392136AbgLKVCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 16:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394686AbgLKVCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 16:02:20 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E2C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 11 Dec 2020 13:01:34 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k2so11346444oic.13
        for <linux-wireless@vger.kernel.org>; Fri, 11 Dec 2020 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6i90QejRWkmIAtoo2m52V+3cpqqI+x/pjz3yRdPtZpM=;
        b=hpKUqu/Ei3mZQTjZ91rz/kKo3nKpA0AKeWbNDuUaE9evS19WtP+NAumpYEfWIGuQqk
         bWFeDC/SuID+CEZ+2NmcHMrgJjVoHwYzajS8lCvBAp4h9V39Mo73Nqj09TKEjbXOafnf
         +qUnX2oA5/GHJIpjW3BOXLQAt/P5UoxkmCz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6i90QejRWkmIAtoo2m52V+3cpqqI+x/pjz3yRdPtZpM=;
        b=e8WFEN0VCEMMJVS61Y1Vbr3nIbo/0ebLrAaeKZJxy7e1mAIHLBNdZCmlNSPJkVX0rc
         H5J8uWWDZhook5bUionnRlnxTsoKLm3E7KKvb1LIsm8KTMt4LW4c/tFngxHvyxKua0ch
         ZZ+im8B3YiEYBwZTDpxUSscLbnQrPFx7zVsTkl8EwMZpf5Q+b2dxxwdFzjSNwFTox8hf
         Z8oo3NsIepSn61MfTw+mGmgBwwcN57fDxSUt+uJi1lTTFiDO9lWRoEnqb6IFMGCeGblt
         27zuIIc+5RMLHKkbjmIKkXOlcWN00KwF+hgT3of6VnFk2G8TFOupDrTLE5Dz3VjDsqWY
         RSvQ==
X-Gm-Message-State: AOAM532Z0x6bPD+iRBngMISW2QwpR/iEulM7f+/6WpcIZ/lmI8tOghqr
        kNUajTICw9UApnXzhIlgPgPYiI85Tz87ag==
X-Google-Smtp-Source: ABdhPJxaA+FMGv7sZKEwsLE631JL4TeXfa8eIqozshKQinaZveFtLUZjYLMEKnnyx80OeOP4G79faw==
X-Received: by 2002:a05:6808:993:: with SMTP id a19mr10682655oic.65.1607720493259;
        Fri, 11 Dec 2020 13:01:33 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id g5sm2093042otq.43.2020.12.11.13.01.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 13:01:31 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id o11so9512233ote.4
        for <linux-wireless@vger.kernel.org>; Fri, 11 Dec 2020 13:01:31 -0800 (PST)
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr9095089otf.229.1607720490665;
 Fri, 11 Dec 2020 13:01:30 -0800 (PST)
MIME-Version: 1.0
References: <1607713210-18320-1-git-send-email-pillair@codeaurora.org>
In-Reply-To: <1607713210-18320-1-git-send-email-pillair@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 11 Dec 2020 13:00:00 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN5UF0KM=xV9e8jTa4XxZ5Tu-yb4yvoaw+56GHx8hf8=A@mail.gmail.com>
Message-ID: <CA+ASDXN5UF0KM=xV9e8jTa4XxZ5Tu-yb4yvoaw+56GHx8hf8=A@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix error handling in case of CE pipe init failure
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>, kuabhs@chromium.org,
        Youghandhar Chintala <youghand@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Dec 11, 2020 at 11:00 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> Currently if the copy engine pipe init fails for snoc based
> chipsets, the rri is not freed.
>
> Fix this error handling for copy engine pipe init
> failure.
>
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Fixes: 4945af5b264f ("ath10k: enable SRRI/DRRI support on ddr for WCN3990")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

Reviewed-by: Brian Norris <briannorris@chromium.org>
