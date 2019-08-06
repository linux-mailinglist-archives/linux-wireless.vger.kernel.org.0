Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4125483D65
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 00:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfHFWhy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 18:37:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45540 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfHFWhy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 18:37:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so42323721pgp.12
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2019 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEBBY/3cfwZghFgvlOug6xWmEiQbNBJw16Nwo29xdMQ=;
        b=nUtwo04zLd++8NyzceuLQ9K5rPwE4gGu6zIueWfxrfY8nWZCU0kg8fQvqSFMpsQRmQ
         q7cQajIFapzT5PtsAXv84Yv+Q12PzvzGuVoYNJWSFn96ZYk2oRAsDx+7oGDdJYlh3SZU
         vncE2/U/+9+bNNhRMisdX5pDtCV9VfdL0WYC5zLnlI6prNunbLw/IrOFuGnKRtahj9lh
         62SsKbFCi5z7wX8KlFYIrjROzRjkI0cIqn57m5YEjel1LUPAcwyaNSTu8jQ/l5zkC5sg
         lHJPlajutsLX9KzuzHnkRgPs2kLJgM+a33EbyoUhJ1a20Vn8ymqfJSIUmBwGORIJp+tX
         hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEBBY/3cfwZghFgvlOug6xWmEiQbNBJw16Nwo29xdMQ=;
        b=rzDiZtXmn1lmha5kxLma6F/5hCDSwbYb/stcGt272/pFNaYPQqqJZUJenWZiElQMqE
         yzWCH43QIQBnUkob0ImS1WngrJoxPwYTxDqlZJu7kq0wOwEbg9TEY0x4eFATqLnic7E1
         HFSVK56XfV8GzSstwWmxyidld/05W2d3/gRptNPmAi2kftyqxfGbb8VKfl1FDNsAXfdY
         59nLe3OMssPdgtISizbUKckSM6WgZyVqwOmncAAP6UKOoN2+/uelEJIdeOekewR9zifL
         Eg8GZCPvoVMLDcEZh10nUa2UPHESyLHXgN0UfSu+mThLjF3/tpxxG/MOzNp78Xd6bQR5
         wDQg==
X-Gm-Message-State: APjAAAVjgRNgyKbScb2ljn2hdfMydxUwLBlZx4t7CJ1AR6eQWtQskeiV
        qFLUQIddx8hgjmWGvefgHivmX7Cj7yfZH35yudP4Ig==
X-Google-Smtp-Source: APXvYqzHiPqnRDL7C3Le9GukRZozDeYh1OFO1GZlcr1HO0BBbZWWYTJ2zvJ4ZVm7JnRYmZj9LOpIn0Rx4wE6vjyUBB8=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr5430397pjs.73.1565131073425;
 Tue, 06 Aug 2019 15:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190712001708.170259-1-ndesaulniers@google.com>
 <874l31r88y.fsf@concordia.ellerman.id.au> <3a2b6d4f9356d54ab8e83fbf25ba9c5f50181f0d.camel@sipsolutions.net>
In-Reply-To: <3a2b6d4f9356d54ab8e83fbf25ba9c5f50181f0d.camel@sipsolutions.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Aug 2019 15:37:42 -0700
Message-ID: <CAKwvOdmBeB1BezsGh=cK=U9m8goKzZnngDRzNM7B1voZfh8yWg@mail.gmail.com>
Subject: Re: [PATCH -next] iwlwifi: dbg: work around clang bug by marking
 debug strings static
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 1, 2019 at 12:11 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
>
> > Luca, you said this was already fixed in your internal tree, and the fix
> > would appear soon in next, but I don't see anything in linux-next?
>
> Luca is still on vacation, but I just sent out a version of the patch we
> had applied internally.
>
> Also turns out it wasn't actually _fixed_, just _moved_, so those
> internal patches wouldn't have helped anyway.

Thanks for the report. Do you have a link?
I'll rebase my patch then.
-- 
Thanks,
~Nick Desaulniers
