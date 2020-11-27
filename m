Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A8D2C65B7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 13:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgK0M0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 07:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgK0M0s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 07:26:48 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A17C0613D4
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 04:26:48 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id o3so4531028ota.8
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 04:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INnUE0sM05L2oreqITOkcAXoqFYcu3Qaos8NOOfhOTQ=;
        b=RbEhXeDCcLG6KFDkofW6vC2lhXZqLixRKztRPhHHADZRxFmCHKdxew/X6buNWyeQPm
         SYTCpiakjEpW+R8ggJqq0BhGj1sINRcXMaxNZK9Tk6K2uGLRZup8ZfiiYKo5zWSddhXs
         ZkaMa3TBB4WEa3vG8H4QlHbg76bimbJQoWPGEYk33YfOdQ1tFIC0mZRG4eyAW1mh6P1T
         kfYL+YsACuuilf3sSPfHlVGeAWtM+oyTeQkb3wiXYjHLho1D1p33cNvAaGnZapYl8OaB
         X8jFOlYbYYiWOAx24QFMufWRlk5KCUEDVZhTzFQN0nL0KeuP9RNuurTu6UfQWwl0y9oc
         hPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INnUE0sM05L2oreqITOkcAXoqFYcu3Qaos8NOOfhOTQ=;
        b=JoLu9hpjamwaXqS54oXURAkP5pNpG85dzx+WZwHLMGNXKgbKVkw8dX0dFTpvy5SsKL
         wp7KlE4dn3bmT10v94GcLaWlhIPfsBf31dsCTlYq7m9p79H1em6prt4aeq+FjVCNsuw2
         R2TMtchkqF1AdU3hwszhQiUkAG9/F0bnbBbzAndJ0R/l9cou2U1BpsJQLX5NxMPGQ7Ll
         /8kQZmcZUlfmMFIhyXfGlhfc5gc0ww/PhF7/REzbjw0BgqMrfy7ysc4cPjJ94kTpXFGK
         2t7kqYWK5s1YMhdiask4fl2fRuVqZNZ1ZVihnajsLT3fkdbUPuLE4glwmf1emrVboYBn
         2kww==
X-Gm-Message-State: AOAM533KU2jFWv6OyLWbqu3Q+uJoDgCv5inrSMvrArjaUR1w04IhJWAS
        zGj9vYDhxXaBvbRhAtgjKh6CIO/L2cYWexhOTUF/1A==
X-Google-Smtp-Source: ABdhPJwdkvpfZpec4AJHnHkvroUWUD22bNL8+btJPZre9LvmpggYaMzTkVMfQJdGNDxedL3NGUqUi0acSmkdra7e+ek=
X-Received: by 2002:a9d:7d92:: with SMTP id j18mr5921417otn.17.1606480007166;
 Fri, 27 Nov 2020 04:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20201125173436.1894624-1-elver@google.com> <20201125124313.593fc2b5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANpmjNP_=Awx0-eZisMXzgXxKqf7hcrZYCYzFXuebPcwZtkoLw@mail.gmail.com> <CAF=yD-JtRUjmy+12kTL=YY8Cfi_c92GVbHZ647smWmasLYiNMg@mail.gmail.com>
In-Reply-To: <CAF=yD-JtRUjmy+12kTL=YY8Cfi_c92GVbHZ647smWmasLYiNMg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 27 Nov 2020 13:26:35 +0100
Message-ID: <CANpmjNO8H9OJDTcKhg4PRVEV04Gxnb56mJY2cB9j4cH+4nznhQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: switch to storing KCOV handle directly in sk_buff
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Aleksandr Nogikh <a.nogikh@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 26 Nov 2020 at 17:35, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Thu, Nov 26, 2020 at 3:19 AM Marco Elver <elver@google.com> wrote:
[...]
> > Will send v2.
>
> Does it make more sense to revert the patch that added the extensions
> and the follow-on fixes and add a separate new patch instead?

That doesn't work, because then we'll end up with a build-broken
commit in between the reverts and the new version, because mac80211
uses skb_get_kcov_handle().

> If adding a new field to the skb, even if only in debug builds,
> please check with pahole how it affects struct layout if you
> haven't yet.

Without KCOV:

        /* size: 224, cachelines: 4, members: 72 */
        /* sum members: 217, holes: 1, sum holes: 2 */
        /* sum bitfield members: 36 bits, bit holes: 2, sum bit holes: 4 bits */
        /* forced alignments: 2 */
        /* last cacheline: 32 bytes */

With KCOV:

        /* size: 232, cachelines: 4, members: 73 */
        /* sum members: 225, holes: 1, sum holes: 2 */
        /* sum bitfield members: 36 bits, bit holes: 2, sum bit holes: 4 bits */
        /* forced alignments: 2 */
        /* last cacheline: 40 bytes */


> The skb_extensions idea was mine. Apologies for steering
> this into an apparently unsuccessful direction. Adding new fields
> to skb is very rare because possibly problematic wrt allocation.
