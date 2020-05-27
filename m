Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5F31E636D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390891AbgE1OMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390727AbgE1OMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:12:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BC1C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:12:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so13584677pfk.12
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:dkim-signature:date:from:to:cc:subject:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1TAYoZI2Tez81wa2zUjdzUAforTt6uKjYATfqebNNbY=;
        b=HmHW8Qlre7Lf/X+jmquS2M5I+cCde2u58b2Kx4GAk5uwNnR9Vv+vN1BMSUdgbZVsvW
         Hm9MRtFxV8RJYlbKR5R2B3S8yxl5Oqbfn3Ts8+zsK/K4FRitKAJ3JdmJ+KJ06/1UoloQ
         8ROZBdVdyeOpeMBlmShp/69uulNB/GlXSeyuZWrl3uN9MSH1csBV88ub2q8GVHiLNFTy
         QGkQ0kwRPoQr+G33SElSs8SBDlu2AIoLv6UcTqcfgahm4zbOuq4mtimoMwhx69A56ALk
         vF0M/cEmb2GUmiFYXdvMiVo8igAoyceMrn9VKxg7gnY7bs3M85PaQ/XBL91psR0Zd89D
         L76g==
X-Gm-Message-State: AOAM531zINY6FvgHoC3iOKdT2wIsMhiHdjHY9P52QUrfZNJ/lja4xMgm
        ZjNf2VPgMZDfevLCgjS+EWYPj3/htp0=
X-Google-Smtp-Source: ABdhPJziJPXqO9Xo8DhEY+qeLZvnK/oaHyvKPgry3E1BaNBRlMqbfvGiE4sthbibI8o61AXAacKhaQ==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr3361436pfu.121.1590675156422;
        Thu, 28 May 2020 07:12:36 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h3sm4300518pgk.67.2020.05.28.07.12.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:12:36 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1446140605; Thu, 28 May 2020 14:12:35 +0000 (UTC)
Received: by 2002:ab0:1445:0:0:0:0:0 with SMTP id c5csp1466085uae;
        Wed, 27 May 2020 14:36:50 -0700 (PDT)
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr4137736ljj.164.1590615410259;
        Wed, 27 May 2020 14:36:50 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; t=1590615410; cv=pass;
        d=google.com; s=arc-20160816;
        b=I2u5IHk0R09L6Re9Wam4U8y5eX9KHPyr7w0JtTb/4gKvnnxtQjpDJdlMrWTGtYNJk2
         Q6tfTIqhhzkQMqOikK3YZ8zKZ7ZfsLRisAP4pUAV6n4BaHKItakInNrGbFV2AhRE5uxm
         ZmKKyC/BP+5pYav72ggOIzpVey+odBHXJT59LY2M+VW3KSy4bx+0ohVyTU7FfqbBJz7/
         Ov+tMiVYqZ7PKvZR9lbOzwBkzT1fWQgego1ipGTyaPA685ZPs2egrVk1cg7nm8ArXzg+
         ZRmqZ5UxSuSXp3kJog47drdhzc10B1J+YroE4PkEGKt5sblJQ+bn+6bMIqJHiNV7+zin
         YWuA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to;
        bh=1TAYoZI2Tez81wa2zUjdzUAforTt6uKjYATfqebNNbY=;
        b=m2jPIPsuCbBGks/0DlsP4FR18PmyZxzpA5cnxzqgXMmOApubAd8KTcpQTK+Yed0YoJ
         kfjGoyR2ZXroxnXedVsnuMldat74ePQ9S8+VSk5WQk0iaO4DjMaDYWSR2eBOin0TUtyw
         JmP/7ebuHoNx55Zq5b46/qbnYheuFjVcmtKJoKDY/IsM5g4AmZrphs6mcxkr1Un5+uX5
         +N+S+YwymGsgM3NymImOC9H8loVrKMUFRHc8Ycmk9fpBZnnWRRndyli8WluaEp84slLC
         /IFdFc1CHz3f57RLn/GyfAP0ubRC87fB1xmE2o0PVY9C/3wcZJV5j0r0UhsRm24Q8Hu2
         nt3A==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b="pEn/j7M3";
       arc=pass (i=1 spf=pass spfdomain=kernel.org dkim=pass dkdomain=kernel.org dmarc=pass fromdomain=kernel.org);
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) smtp.mailfrom="mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com";
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id j21sor2391552ljg.43.2020.05.27.14.36.50
        for <mcgrof@gmail.com>
        (Google Transport Security);
        Wed, 27 May 2020 14:36:50 -0700 (PDT)
Received-SPF: neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com) client-ip=209.85.220.41;
X-Received: by 2002:a2e:9586:: with SMTP id w6mr3764348ljh.274.1590615409897;
        Wed, 27 May 2020 14:36:49 -0700 (PDT)
X-Forwarded-To: mcgrof@gmail.com
X-Forwarded-For: mcgrof@do-not-panic.com mcgrof@gmail.com
Received: by 2002:ac2:5305:0:0:0:0:0 with SMTP id c5csp1435734lfh;
        Wed, 27 May 2020 14:36:48 -0700 (PDT)
X-Received: by 2002:a17:90a:d818:: with SMTP id a24mr375362pjv.75.1590615407957;
        Wed, 27 May 2020 14:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1590615407; cv=none;
        d=google.com; s=arc-20160816;
        b=AYTqKoe7rBll25R4xlQw9cJ7tKSZv/KnhhmGamBU+R8z71sZ4BV7qLIwTld+ALtQGF
         qiWZD9cMECM3kA4eHnftWYqbYGYh3W1ANouRT7VUsBxOBxRGyPswf8B1xjbQbhRuqWUk
         tzypHlqrzX3kPNQIB+Gr3/RIn9tpeVjRIp/rHGXJytbMOdrA7liG1XiyGILwW2QCKQ1w
         GiNANie/sHlBnwqJZiFuw8FrFGCnh9+h/mkK5TU5sHVNG0ksCCSPGkp/pkoUMYz7rf/u
         ztFGzh256aCK0tgipZod3kV6c5quoBKR3suJQeJ5qkT1PHbG7ttiH+ou37gQVoNb387R
         /d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to;
        bh=1TAYoZI2Tez81wa2zUjdzUAforTt6uKjYATfqebNNbY=;
        b=SEH2CNHZ11L5faPOVr63jTgWAGV1MGSlgfFT5AsIW5Eht4zwBDOmBUYpPuM4HHpgw5
         xVXer0uXscEaEDui84bcmyv5mQg8phTMl8UxSEIUXHWEH8wzGLB6yjkL/h/wFLchCHJt
         KiRXvT2HtF6RhvW5laRKtZNmfcVB7f9Kwypiwys45iJFnfiaibVbX/pOS+b8+C7B9xRj
         uvZzA0iN/qMPhQcnj38xT/tGcuOETKZL+MlgLc6AnF5/0Ab2GJ6QSa4lxQAMUsrhKzLv
         ZIJEcMHN6KacSeNwhldJ9CbfwiZZVyF81RWl7fe55URgegU9J2Jpv1HI5EYujkmyrgtY
         ctPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b="pEn/j7M3";
       spf=pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=kuba@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by mx.google.com with ESMTPS id b10si3248426pfb.50.2020.05.27.14.36.47
        for <mcgrof@do-not-panic.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 14:36:47 -0700 (PDT)
Received-SPF: pass (google.com: domain of kuba@kernel.org designates 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
Received: by mail.kernel.org (Postfix)
        id 3A9C220FC3; Wed, 27 May 2020 21:36:47 +0000 (UTC)
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58682075A;
        Wed, 27 May 2020 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590615407;
        bh=C9QEYysDx6SvB7HQ2r/V2aV8FyGMNYUnIYiRPLfFE30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pEn/j7M3tLS4ZOl7rth/Oooe+DMEkDN3gAtt4X3XMA85BrFencKsNhrsgxjIaV0OJ
         PeLdwJ4B+qqrg2B2psuZpeq6XlnRQR5EOzYmN1/sjPUhhpE9jY58muoqH2/URMzzT9
         0tpVflTTmTUl0mtXerelfd+dd1qFkYbAQRV21OXU=
Date:   Wed, 27 May 2020 14:36:42 -0700
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
Message-ID: <20200527143642.5e4ffba0@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20200527031918.GU11244@42.do-not-panic.com>
References: <20200526145815.6415-1-mcgrof@kernel.org>
        <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20200526230748.GS11244@42.do-not-panic.com>
        <20200526163031.5c43fc1d@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <20200527031918.GU11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TUID: Hh3RN+BezS5Y
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 27 May 2020 03:19:18 +0000 Luis Chamberlain wrote:
> I read your patch, and granted, I will accept I was under the incorrect
> assumption that this can only be used by networking devices, however it
> the devlink approach achieves getting userspace the ability with
> iproute2 devlink util to query a device health, on to which we can peg
> firmware health. But *this* patch series is not about health status and
> letting users query it, its about a *critical* situation which has come up
> with firmware requiring me to reboot my system, and the lack of *any*
> infrastructure in the kernel today to inform userspace about it.
> 
> So say we use netlink to report a critical health situation, how are we
> informing userspace with your patch series about requring a reboot?

One of main features of netlink is pub/sub model of notifications.

Whatever you imagine listening to your uevent can listen to
devlink-health notifications via devlink. 

In fact I've shown this off in the RFC patches I sent to you, see 
the devlink mon health command being used.
