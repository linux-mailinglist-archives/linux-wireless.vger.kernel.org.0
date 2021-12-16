Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818124779D8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 18:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhLPRBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 12:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhLPRBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 12:01:30 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803D3C061574
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 09:01:30 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id d11so14909088pgl.1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Dec 2021 09:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QBRrIssPjT5UJX69F/vNmr0R7wGmB/uhIG8pb75Uag=;
        b=k7J/ED6aP3spMcK4er6SznI/94a9NHlSthGxsA/GRlgEeN7sHl6OeZP+U42EKH9aJ1
         /QUojcjCvRi19yrsRotwwMRx4QQUfpcJBMKU1oSyN7nZIw3I8OvglEwKOz6IEOxEffqn
         lbojvYDLaweYsg7on7lqcU8I5sbYicOoRjAtvwIPoOmJFvw0vjWVfmgfsmCQ0cJZHlAe
         Ua6L0RrHbVXpyzbyGBO1y3iOATTIi4dtFV1jm/TsFLCE/8IwjIMcWEmB+93KNpVDenP1
         LgYZ9rPoY5mHkrVFfvQFD1MrDNDd4VfH6U4RqS538zTMO1OXE9Ugqh1qPcG2ka9gIVSs
         sLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QBRrIssPjT5UJX69F/vNmr0R7wGmB/uhIG8pb75Uag=;
        b=E6qwUcUJlvkWr16imTKOA04tjOsJMdYQhKgdfkmMfdMK98FTY0GMXFA6vlunkW7QK6
         6b/cdCDOEGvO28m9P/UJTCguub+7h2Ac+Yv6a6t+0d6f8t0b8/3r3/T2i8ZwxEVCpBuG
         KJYevnsMBspfOsoLfpd0UU5AndCJGSZeai6u3RsR+f2uIAUhqZwYY1K9Agpl+h+zLvyT
         lzdHjNow2/vB0mfjgrJMUzbw5qWX0LoHQ4CfDDd8ZZQ/QDAEaELJRmtSlN6poDnUN11y
         1/i3OEYZebNsF6aaR+JQchpnM6wsbjBc8aXwdMc84ScgNhvMbPa985ptwjW5XvNPMY8r
         yE/Q==
X-Gm-Message-State: AOAM532wqxg4IJX5Ks84WmWAnG3jvpx+gXxj5DJxNOuFtt1x0MeiNi4f
        X6h1BMIf/6R2gEHjA/frH5KbYkvaFQKRABE6EC5hvWCvclc=
X-Google-Smtp-Source: ABdhPJy3A3LttOae3JCBgSw7677bhe45HfzXzxI3gE6q5EUqlhGK4ptVAS07dunW0W7ZdtBSb5kn2CUL1OxCYPal1gk=
X-Received: by 2002:a63:1b02:: with SMTP id b2mr12842353pgb.263.1639674089660;
 Thu, 16 Dec 2021 09:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20211215215042.637-1-jelonek.jonas@gmail.com> <87sfusbk7p.fsf@codeaurora.org>
In-Reply-To: <87sfusbk7p.fsf@codeaurora.org>
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
Date:   Thu, 16 Dec 2021 18:01:18 +0100
Message-ID: <CAChE-vQ4nHJgScH+jRTkb23-=3x2_odXO3J6SVcqb6BAcAbqvA@mail.gmail.com>
Subject: Re: [PATCH] ath5k: switch to rate table based lookup
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks for your review!

Kalle Valo <kvalo@kernel.org> writes:

> I'm not really a fan of ? operator, so in the pending branch I changed
> this to use a normal if statement. Please double check that I didn't
> break anything.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=9e7c92df342f884434ccc8635d2606c1d1b11ef9

Checked this just a few moments ago, still works fine.
