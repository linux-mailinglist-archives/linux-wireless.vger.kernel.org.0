Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710FD3B376E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 21:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhFXT7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 15:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXT7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 15:59:20 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C0C061574
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 12:57:01 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id e7so2655331uaj.11
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d4+8SUdtiuKGmqe6FBgtAiI0aNyLkTa+3Inrevk5H0=;
        b=OypnznC6Lkav9yidTPEhCW+wUxiS9BAW7BoFUR6KJbGaPPhdB438ce2+SMWYPgFDhs
         vx9uN/E120itk0R5Gu0NE8lTPMBSLPa4XDnGOD7Tr0aaD10IiCEbx32H7GGksdtjXIGX
         nY0+Ie1wZuz/Xad+IGe8/KhYcsPemo5k5yPTDMA8fKgI6VjLE019mJ7CJwX7v8IheBlB
         9MEqYCA7sv7+WllaV1QPTAiYB41FydZY1rEUDhwj1ZjM4TL3jCWqYlnMRKii0mcpDp1K
         pni6NIYFJkobbAAvJ/PZo6D6AELIqa0gMw3116kjfmve7qF5Iqztshy9yI5mbvBX/D3Q
         96Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d4+8SUdtiuKGmqe6FBgtAiI0aNyLkTa+3Inrevk5H0=;
        b=tvhM9PVHKcYMXUGOg51/ILvd8ElE9YVyD5TynVBRM+04LzXjNgIpKvuxfrKNtk4IGh
         LntaYMXlCpg4u9QjcAXfNQasu0SBeZL+AoCf97cD6tPpmyidAAypobjLVrPL2nQWSe+e
         pBEs/1tqmYloV8+l2U/5tmkWmoWAzP0pzP40IEJzrmPnPYZDkM+2HGMW0S9r/1La+au1
         rnNOeLpGiUw4Vb5a/vW5/iy4W1LA3f6LuO7kGmgfWMIm5UsWj3+z7OVPHK1t6ts/nD2N
         w639un//Gl9Tg5N3wt7y3NJ2QXQoYLZwzZYE3KE33M+SRJzqCXfqNIzchSsm3Z05if8U
         ZMtA==
X-Gm-Message-State: AOAM5313PXq3pNQfKzt8RoyTHGoFO02uHUgEggl5RzyDWTUPrRska2k1
        RsvoHz9MqRGs86G8BItbslfAGnt/9Ty+bwN+K+onH9h+seyt5w==
X-Google-Smtp-Source: ABdhPJxVduDhieFKFQBZPbsR1PoHQGMgzbnpCwYfJc/53SKJCwqq7xudijqxnJWka5J6agxF2yBojN1XW+lqV2PPAWc=
X-Received: by 2002:ab0:5962:: with SMTP id o31mr7616347uad.89.1624564619964;
 Thu, 24 Jun 2021 12:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com>
 <20210623141033.27475-3-emmanuel.grumbach@intel.com> <87k0mji43p.fsf@codeaurora.org>
In-Reply-To: <87k0mji43p.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 24 Jun 2021 22:56:49 +0300
Message-ID: <CANUX_P0d0jrq9x99jM824oKOhmi0Wa5WqhECMsX=hd269H6atw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] nl80211: vendor-cmd: add Intel vendor commands for
 iwlmei usage
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 24, 2021 at 8:09 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>
> > iwlmei allows to integrate with the CSME firmware. There are
> > flows that are prioprietary for this purpose:
> >
> > * Get the information the AP, the CSME firmware is connected
> >   to. This is useful when we need to speed up the connection
> >   process in case the CSME firmware has an TCP connection
> >   that must be kept alive across the ownership transition.
> > * Forbid roaming, which will happen when the CSME firmware
> >   wants to tell the user space not disrupt the connection.
> > * Request ownership, upon driver boot when the CSME firmware
> >   owns the device.
>
> Vendor command requirements are documented here:
>
> https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api
>
> The commit log is not really answering to those. For example, how a user
> would use this? Or is there a user space tool?

We intend to send those command from the NetworkManager.
I'll write a commit message that explains this better.
The gist of it is that the user space will see that the NIC is not
owned by the host thanks to the new RFKILL reason that I added. Then,
it can ask CSME what AP it is connected to, check if it has the a
profile configure for that AP and connect to that same profile.
I'll respin.

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
