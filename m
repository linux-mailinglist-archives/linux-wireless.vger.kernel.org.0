Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164B1E6370
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390898AbgE1ONB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:13:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37588 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbgE1ONA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:13:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id x10so11598181plr.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dk0pTdJumqtR3muV1AGluDpJHnN6Xn6bW+DtSZAfKr0=;
        b=A7IJFrCLcKFA1Vz1cTo65EPmUfSCxuHhoMTMtncWrKA/KPezvzFD8GQgU0BbVutJvB
         nOcHQxHMvfsMhukwqYx1Sxhssxxj0LIBGnIwZMUhi5iIY7kZJnNjgC/1NA3EMtKdrc8R
         0KTJEQx9n1IRo3PpVFraCU8TROaKN/mow6bBTL8sV//XQWT6kd8C8QKzHLQCeoBn8CqL
         KwH8iFbkWA4KcZpZDhVlVtthy3LPUBd432I++/wr/WhgmVLIEyetInry3wzAOcU84Uhl
         +reWXn321cuFuig8tz3Mhabc9PClMUvZLe19Wtv387JwjZE55y1KjtU6bQVrCGwHQEq4
         FCjA==
X-Gm-Message-State: AOAM531N4pT62WE29lPNNZjpO5Gdvw7dh9k7U2ENiJvFzdFfn3f24zQU
        pK5LCUOj0UFVekbOEh5bKdTUCZy7GJM=
X-Google-Smtp-Source: ABdhPJxwjopxA1WzFrWH4bTLxYm7VxwL8CkHh3Iy+dACgFVmaN+nc0kLBu7yPqZ5kVwHUpIq/RT7iw==
X-Received: by 2002:a17:90a:890b:: with SMTP id u11mr3983711pjn.233.1590675179309;
        Thu, 28 May 2020 07:12:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r31sm5346419pjg.2.2020.05.28.07.12.58
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:12:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1683940605; Thu, 28 May 2020 14:12:58 +0000 (UTC)
Date:   Tue, 26 May 2020 23:07:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jeyu@kernel.org, davem@davemloft.net, michael.chan@broadcom.com,
        dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        kvalo@codeaurora.org, johannes@sipsolutions.net,
        akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        derosier@gmail.com, keescook@chromium.org, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/8] kernel: taint when the driver firmware crashes
Message-ID: <20200526230748.GS11244@42.do-not-panic.com>
References: <20200526145815.6415-1-mcgrof@kernel.org>
 <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 26, 2020 at 03:46:06PM -0700, Jakub Kicinski wrote:
> On Tue, 26 May 2020 14:58:07 +0000 Luis Chamberlain wrote:
> > To those new on CC -- this is intended to be a simple generic interface
> > to the kernel to annotate when the firwmare has crashed leaving the
> > driver or system in a questionable state, in the worst case requiring
> > full system reboot. This series is first addressing only a few
> > networking patches, however, I already have an idea of where such
> > firmware crashes happen across the tree. The goal with this series then
> > is to first introduce the simple framework, and only if that moves
> > forward will I continue to chug on with the rest of the drivers /
> > subsystems.
> > 
> > This is *not* a networking specific problem only.
> > 
> > This v3 augments the last series by introducing the uevent for panic
> > events, one of them is during tainting. The uvent mechanism is
> > independent from any of this firmware taint mechanism. I've also
> > addressed Jessica Yu's feedback. Given I've extended the patches a bit
> > with other minor cleanup which checkpatch.pl complains over, and since
> > this infrastructure is still being discussed, I've trimmed the patch
> > series size to only cover drivers for which I've received an Acked-by
> > from the respective driver maintainer, or where we have bug reports to
> > support such dire situations on the driver such as ath10k.
> > 
> > During the last v2 it was discussed that we should instead use devlink
> > for this work, however the initial RFC patches produced by Jakub
> > Kicinski [0] shows how devlink is networking specific, and the intent
> > behind this series is to produce simple helpers which can be used by *any*
> > device driver, for any subsystem, not just networking. Subsystem
> > specific infrastructure to help address firwmare crashes may still make
> > sense, however that does not mean we *don't* need something even more
> > generic regardless of the subsystem the issue happens on. Since uevents
> > for taints are exposed, we now expose these through uapi as well, and
> > that was something which eventually had to happen given that the current
> > scheme of relying on sensible character representations for each taint
> > will not scale beyond the alphabet.
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>

Care to elaborate?
 
  Luis
