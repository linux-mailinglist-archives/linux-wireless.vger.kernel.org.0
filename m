Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6367B35ED44
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 08:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241121AbhDNGi6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 02:38:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53007 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhDNGiu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 02:38:50 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lWZAS-0008In-Sa
        for linux-wireless@vger.kernel.org; Wed, 14 Apr 2021 06:38:28 +0000
Received: by mail-lj1-f199.google.com with SMTP id n1-20020a2e90410000b02900bddb911a15so726982ljg.16
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 23:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vpy9LWiinO4ScHbapsEDf4+eNTEhFKmqhQxyJ0u+ghI=;
        b=VK3wm/a6GFwU3AIQgJrazzC67g4oRGdgwVdUKHC8a7OimkGnFThjkV4Od1C2sWtKxD
         Qp7gIs+uzpJzMHn564fGCe3X+3W+qr/BIXP+xXhPgvkEPJwaA67C+U/yo7b8NPxK7t51
         YRpOj+YQAKomOTsc2u0gSF66xQnrdGbfoU+VJIMTZM8/ASWfZIdrII7yV1wkbC0wos7K
         yIibJxLvwkcQGj7MaaTLQo/6okAe03JQcX1pzYcSsWn4XU5rXG+ZjeVWrneheiIJwjwl
         GQlb5E15bzfuesJGO/k0gZJBGKHVKfmMn90KRHmjLxy/TbM3N5Kv5m3kj1IPPniye8Gg
         BOrA==
X-Gm-Message-State: AOAM533OKDpI1rwM5MpV8eT4kqcMX/GiRSrCK/Ktvn6kU8I5Eybc5bEU
        /4aN9MgD22bs5uPQSOo1RlXF5yRlgIBmWvE6oyHSvvoBNB3+0GKdFIkCxuUxHjdN+pQo3m9k2I/
        edUC5e4I+JgxKHXYjfRrZOWX1a1LiKdmfXxnDyH3L3c/3iyALv3LtMIy1O1k1
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4164990lfa.10.1618382308306;
        Tue, 13 Apr 2021 23:38:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbIuY4VIq0q97zDmDsqgnTFtU4PdxaE89Cw+8ZAKVkHMV8lN5sgBp+PGrKzVLko8VvVoHWCOEjxKQTQrzlFRc=
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4164971lfa.10.1618382307998;
 Tue, 13 Apr 2021 23:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210219052607.7323-1-pkshih@realtek.com> <87zh00jzlk.fsf@codeaurora.org>
 <1613719728.11718.3.camel@realtek.com> <87v9aojysp.fsf@codeaurora.org>
In-Reply-To: <87v9aojysp.fsf@codeaurora.org>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 14 Apr 2021 14:38:16 +0800
Message-ID: <CAAd53p5AG6CBC5t=-fbV5DwtsCzPBoKU8jGj2j_SfQx9GV_f8Q@mail.gmail.com>
Subject: Re: [PATCH] rtlwifi: 8821ae: upgrade PHY and RF parameters
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Fri, Feb 19, 2021 at 3:36 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Pkshih <pkshih@realtek.com> writes:
>
> > On Fri, 2021-02-19 at 09:17 +0200, Kalle Valo wrote:
> >> Ping-Ke Shih <pkshih@realtek.com> writes:
> >>
> >> > New parameters with new format and its parser are updated by the
> >> > commit 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser."),
> >> > but some parameters are missing. Use this commit to update to the novel
> >> > parameters that use new format.
> >> >
> >> > Fixes: 84d26fda52e2 ("rtlwifi: Update 8821ae new phy parameters and its parser")
> >> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >> > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>
> >> What does this fix from user's point of view?
> >>
> >
> > The signal strength of 5G is quite low, so user can't connect to an AP far away.
>
> Thanks, I'll add that to the commit log and queue the patch to v5.12.

Is this patch included in your tree? At least I can't find it in the -next tree.

Kai-Heng

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
