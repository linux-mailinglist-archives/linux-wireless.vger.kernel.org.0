Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D7B27B316
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgI1RY4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgI1RYx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 13:24:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C81C0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 10:24:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q123so1679350pfb.0
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dXB5sy6RuZTJPqx7JJLXNWe1a908CXA07ElMJ2w7R68=;
        b=sJXRxO3VX4I/D6OKhoVkZO/piViwl1rsupkYazfFzknNozgI8OsHjhRNoJktdix5sL
         XUePafekvxNj5dX2ZMNgPcxdgvjKnkbGxEJHb5M7MD6jsXR24Z16f7Q8EMF5gSrpcqV3
         6mdJsMem+f4C7b9Iy8bk9humZkeCkuU0VDUAFi3VrIZ1AvBJykcO3j/m813G3+0PUELA
         8jig6g1XAuBTfOqXNacgr0soT1uIdlZZ/QhywRu6HBMy1Ncr+lfoiCUVKIuNsV2E8yzC
         6Etpltkq/5EZsG8x+m98hzY644sBlZD9g9rlktFFEXZxJkhYAnrqwKkSvnbtDB8ytbwH
         WhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dXB5sy6RuZTJPqx7JJLXNWe1a908CXA07ElMJ2w7R68=;
        b=RGDC5jE/RViGZjrZfNw6/QcwTIGje42QDRpNxjLUy7IVTfBXt+3vPiNBSSAhHBTzo9
         5pHa5YS42TR6QFEM8aSE+Qx62okQwy96R1OOcOfaqsy58CJzc9JVTZt0B397XYyo3Hdm
         j9KyeqSlDGSF8KfGkIYgZfGer+Kq8nl0ld6AKx7nHQPtQnmmvVJ44LfqLiuHRqistgH+
         0BbOErT/sJeoAQIDm+V1fGcsYRDqYZyKsA1Rq8HFe/tGALMcc6UiTZrln1CbvQgGE345
         UDzY3NnUlxIs4vgd/1K0T52+kyeScncr/PssujgoreD8+Rqo12l54cAJqqjBWadH6A+K
         kdZQ==
X-Gm-Message-State: AOAM530gF1HQx2jRSTaDLsEYbv6P8PWro0vpHsU6wNGQz2MZpUgMHouY
        kN36SbsnKgy1XeTw8xGaCrp9Tg==
X-Google-Smtp-Source: ABdhPJyoyl1fomYslG+xBdkpZIhAHLVX6EHj3huo2N9gQMS+dYAudkP3ZT0Owaa2qZhTwb+CGqQqNA==
X-Received: by 2002:a63:784:: with SMTP id 126mr121408pgh.428.1601313891289;
        Mon, 28 Sep 2020 10:24:51 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id u71sm2511314pfc.43.2020.09.28.10.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:24:50 -0700 (PDT)
Subject: Re: [patch 11/35] net: ionic: Replace in_interrupt() usage.
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        Vishal Kulkarni <vishal@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Martin Habets <mhabets@solarflare.com>,
        Jon Mason <jdmason@kudzu.us>, Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jouni Malinen <j@w1.fi>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        libertas-dev@lists.infradead.org,
        Pascal Terjan <pterjan@google.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <20200927194846.045411263@linutronix.de>
 <20200927194920.918550822@linutronix.de>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <5e4c3201-9d90-65b1-5c13-e2381445be1d@pensando.io>
Date:   Mon, 28 Sep 2020 10:24:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927194920.918550822@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/27/20 12:48 PM, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> The in_interrupt() usage in this driver tries to figure out which context
> may sleep and which context may not sleep. in_interrupt() is not really
> suitable as it misses both preemption disabled and interrupt disabled
> invocations from task context.
>
> Conditionals like that in driver code are frowned upon in general because
> invocations of functions from invalid contexts might not be detected
> as the conditional papers over it.
>
> ionic_lif_addr() can be called from:
>
>   1) ->ndo_set_rx_mode() which is under netif_addr_lock_bh()) so it must not
>      sleep.
>
>   2) Init and setup functions which are in fully preemptible task context.
>
> _ionic_lif_rx_mode() has only one call path with BH disabled.
>
> ionic_link_status_check_request() has two call paths:
>
>   1) NAPI which obviously cannot sleep
>
>   2) Setup which is again fully preemptible task context
>
> Add 'can_sleep' arguments to the affected functions and let the callers
> provide the context instead of letting the functions deduce it.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shannon Nelson <snelson@pensando.io>
> Cc: Pensando Drivers <drivers@pensando.io>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org

Acked-by: Shannon Nelson <snelson@pensando.io>

> ---
>
> While reviewing the callpaths, a couple of things were observed which could
> be improved:
>
> - ionic_lif_deferred_work() can iterate over the list. There is no need
>    to schedule the work item after each iteration

I think the original writer's intent was to avoid monopolizing the work 
thread for very long on any one cycle, with the thought that we'd be 
making more use of this than we currently are.  I'll address this.

>
> - ionic_link_status_check_request() could have ionic_deferred_work within
>    ionic_lif(). This would avoid memory allocation from NAPI. More
>    important, once IONIC_LIF_F_LINK_CHECK_REQUESTED is set and that alloc
>    fails, the link check never happens.

Thanks, I'll fix up that error condition.

>
> - ionic_lif_handle_fw_down() sets IONIC_LIF_F_FW_RESET. Invokes then
>    ionic_lif_deinit() which only invokes cancel_work_sync() if
>    IONIC_LIF_F_FW_RESET is not set. I think the logic is wrong here as
>    the work must always be cancled. Also the list with ionic_deferred
>    work items needs a clean up.

I'll look at that, thanks.

sln


