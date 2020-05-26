Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2181E636C
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbgE1OMF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbgE1OME (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:12:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19791C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:12:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n15so3155563pjt.4
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:dkim-signature:date:from:to:cc:subject:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=98j+1Zgwc4rnj6lErqeuXM1CDLn4VxWIkmeePujXBKA=;
        b=G4zJHCq2VQAB5/fjU19YFHzvuA+8QcmqghzemS4UgtDTXDWuYEOqSXHNgH130m/yOc
         rI5B0MliuJ6wQRSB77KH6NO1CRiLE38lO2am1C8sGspBFvseu1L7jhVHgjMHSyZQgeSV
         SlLvZdSATsHOY4iaKiZwrKuRuOkIE9N892l+fVJFbP5dIFrMbDLv+nIjQVUJrByzEleo
         vXzCfS0LRQyDLO235rzi9o4NOTAuJ5YaXFpE2lhwk1FKGUmkBY6i2EepZ7sFLlZKLsrq
         NQo71BJWPxh3sjoOLvlfFZSu3mWubPV5S13fRggnx7/DFwXwKbXDd81DwsD2SDr9Q3tY
         qqPA==
X-Gm-Message-State: AOAM531V65F2OimiHF+j1UBqJURmIkDPEFRuoQiyRdHLKayqBJBLY35K
        T1YgL0b2bt7H43kOoj+a5d/UISH0HVw=
X-Google-Smtp-Source: ABdhPJxAjkDAhBqNQtv7GndjE1pVhh3dqb/QbVjr67PBiY7mjXit9x8Aom25e55MvXGRPt3rrlFFzA==
X-Received: by 2002:a17:90b:4c52:: with SMTP id np18mr4033813pjb.35.1590675121798;
        Thu, 28 May 2020 07:12:01 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 6sm4986361pfj.54.2020.05.28.07.12.01
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:12:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C579B40605; Thu, 28 May 2020 14:12:00 +0000 (UTC)
Received: by 2002:ab0:1445:0:0:0:0:0 with SMTP id c5csp645234uae;
        Tue, 26 May 2020 16:30:38 -0700 (PDT)
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr1652840lfq.170.1590535838421;
        Tue, 26 May 2020 16:30:38 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1590535838; cv=pass;
        d=google.com; s=arc-20160816;
        b=qrK1AfhlZGgHkeb6EccX7Z/mUkcu67mXtQNWzduRAJa3hNq1rWMFbHFVNst3ez3hmn
         ZY0wCUdxVFvrvymWoi7j92RCldGp3Nn1YlwNWP30jgM4LNZru3WwiZ/SyN7Gn3SPcWsZ
         1txSWnYNHTlhm9/O3NPEue6CYHONutmMqKeKkBWJnBFpESgZXeYbkxvTdVZO4I2BUll4
         I2e2KanyYRW+G14JAqTkBv0Xeh/wiySwQN34PvxH0/BUWj28CsGVFZXp23YPne0aJ+n2
         08nKudvIH0JIF1kxSQpr+mNfNf4zsOmW8zfsiIeSVgIsZmQg/kqBYzKelVdfolbmGwLZ
         1fUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to;
        bh=98j+1Zgwc4rnj6lErqeuXM1CDLn4VxWIkmeePujXBKA=;
        b=ky1p+vteIWjPg9wH07rtCo8wKDUdY9g/rAcS+8O5OpOCRj08CIZKRXhVUmNQumy+l5
         SdyAE/WF7F/bV4XpoL7s1GBYoPnmORBKewRYphhOJhgAxnhur/E4vfI+7vKiXBPuDdMc
         BpM9E583AqQD2KyappMAAt4d8B5XN6qPYATKv+LSa5Jhph28aYMnweVqAH8B+tbZ5RHD
         RzEHEcw9nz2De7zZjQsIFm7m7IfdkJQ46lcpvcyIVralIL5Q0b33lqHL7nqSr2+c+d06
         fm3qaWgZY/yMKtxLAfpKxprJJ5lc6+0BwtgYFUV+FdlOwLlF8hf28bQ5CYmkbmkXVrNz
         No6g==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gWBafBW4;
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=kernel.org dmarc=pass fromdomain=kernel.org);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) smtp.mailfrom="mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com";
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id u26sor617495lji.77.2020.05.26.16.30.38
        for <mcgrof@gmail.com>
        (Google Transport Security);
        Tue, 26 May 2020 16:30:38 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) client-ip=209.85.220.41;
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr1594947ljk.144.1590535838072;
        Tue, 26 May 2020 16:30:38 -0700 (PDT)
X-Forwarded-To: mcgrof@gmail.com
X-Forwarded-For: mcgrof@do-not-panic.com mcgrof@gmail.com
Received: by 2002:ac2:5305:0:0:0:0:0 with SMTP id c5csp572509lfh;
        Tue, 26 May 2020 16:30:36 -0700 (PDT)
X-Received: by 2002:a17:90a:338b:: with SMTP id n11mr1723643pjb.225.1590535836424;
        Tue, 26 May 2020 16:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1590535836; cv=none;
        d=google.com; s=arc-20160816;
        b=M9BNbL06rP7WdpRE8Nx4e0attZYUt75uwZJBYWZRPIDahz8K1HHbfOFW27aDJ4gjXG
         ds11WRZKamq8LWFq7Cxe/Z/2tgUOY/CMx34Sdtkv0d1F0i4j0PTxLEpPECpr7lR+ZO0d
         1I7CjPeG4tXP1KPPwu0MDIBuFXMi2j/1r/YICUzE3DxwznOhGIyOANnoOx0n1j5URsQo
         ygpJIW5GRbkJhHZHY3/FicJHHunTSDuQDXlj+qUe6QNlE+4ekGMLU24ytqen1RkeLs95
         o1Ha4ir3D1U3S+TJuParlxWOKzs7xBnSjdPmciRLSBQHlw5d5SpAqHYMDHUiwDRgZsM+
         UfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=98j+1Zgwc4rnj6lErqeuXM1CDLn4VxWIkmeePujXBKA=;
        b=a4XkK/AXk80OOARcp5FKUf4iqYnV5dbucdCsEepXS/wHULFUVnjf/SkQZ/CAZBzur7
         jEVk+JE+N09GePCbKuQ5+CQF2oFgva7RTyjKmwPTyq+6sVtGO9CkdRdbzuRuKZDzWvtc
         BGBhZfIQ1u4NGVjcbFbPZJqGsH/1gtrQAiq+SmHTf8xU/1JJaHgVtT/XiVV2hK0WiI+L
         plLaBi/1N15upsOTZ+ww3MtTf874Si2S/LL4qwyyLOUvDZWY8NTlw2xpgPGGZGj1Y30C
         xIWn9bbcDnrLHkbuPJkxNWHs3LAdmn4D8TMaN/0aQlD11LwDVux+xlDaZrbK/vMeUs6g
         /c5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=gWBafBW4;
       spf=pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=kuba@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by mx.google.com with ESMTPS id x6si845400pgb.582.2020.05.26.16.30.36
        for <mcgrof@do-not-panic.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 16:30:36 -0700 (PDT)
Received-SPF: pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Received: by mail.kernel.org (Postfix)
        id C3AF420899; Tue, 26 May 2020 23:30:35 +0000 (UTC)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6284E20849;
        Tue, 26 May 2020 23:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590535835;
        bh=Xktrl3iNjlq0DQXfwLdVjcGbCxddHqzKTW9NLLNfCJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gWBafBW4xmfM510bdgGP9VD6NlS0DEcl9k/xoj8aRIgRQr1cER0h4d8UH2ikHPEC/
         Z6wbMTiItGU4h1LEcShc76dEKFrOD1DFYE7/ju8aQ4qRb/XVrr5wS0Cq0I/AyvWQ/v
         5f8RfOWYtfl8yRzTsPUHo3U3jFsuxw65wDiFZp5U=
Date:   Tue, 26 May 2020 16:30:31 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <20200526163031.5c43fc1d@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20200526230748.GS11244@42.do-not-panic.com>
References: <20200526145815.6415-1-mcgrof@kernel.org>
        <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20200526230748.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TUID: +VUjQoL96qhG
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 26 May 2020 23:07:48 +0000 Luis Chamberlain wrote:
> On Tue, May 26, 2020 at 03:46:06PM -0700, Jakub Kicinski wrote:
> > On Tue, 26 May 2020 14:58:07 +0000 Luis Chamberlain wrote:  
> > > To those new on CC -- this is intended to be a simple generic interface
> > > to the kernel to annotate when the firwmare has crashed leaving the
> > > driver or system in a questionable state, in the worst case requiring
> > > full system reboot. This series is first addressing only a few
> > > networking patches, however, I already have an idea of where such
> > > firmware crashes happen across the tree. The goal with this series then
> > > is to first introduce the simple framework, and only if that moves
> > > forward will I continue to chug on with the rest of the drivers /
> > > subsystems.
> > > 
> > > This is *not* a networking specific problem only.
> > > 
> > > This v3 augments the last series by introducing the uevent for panic
> > > events, one of them is during tainting. The uvent mechanism is
> > > independent from any of this firmware taint mechanism. I've also
> > > addressed Jessica Yu's feedback. Given I've extended the patches a bit
> > > with other minor cleanup which checkpatch.pl complains over, and since
> > > this infrastructure is still being discussed, I've trimmed the patch
> > > series size to only cover drivers for which I've received an Acked-by
> > > from the respective driver maintainer, or where we have bug reports to
> > > support such dire situations on the driver such as ath10k.
> > > 
> > > During the last v2 it was discussed that we should instead use devlink
> > > for this work, however the initial RFC patches produced by Jakub
> > > Kicinski [0] shows how devlink is networking specific, and the intent
> > > behind this series is to produce simple helpers which can be used by *any*
> > > device driver, for any subsystem, not just networking. Subsystem
> > > specific infrastructure to help address firwmare crashes may still make
> > > sense, however that does not mean we *don't* need something even more
> > > generic regardless of the subsystem the issue happens on. Since uevents
> > > for taints are exposed, we now expose these through uapi as well, and
> > > that was something which eventually had to happen given that the current
> > > scheme of relying on sensible character representations for each taint
> > > will not scale beyond the alphabet.  
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Care to elaborate?

I elaborated in the previous thread and told you I will nack this, 
but sure let's go over this again.

For the third time saying the devlink is networking specific is not
true. It was created as a netlink configuration channel for devices
when there is no networking reference that could be used. It can be
compiled in or out much like sysfs.

And as I've shown you devlink already has the uAPI for what you're
trying to achieve.

Regardless of your opinions about wider interfaces, networking drivers
should implement devlink, and not have to sprinkle magic taint calls.
