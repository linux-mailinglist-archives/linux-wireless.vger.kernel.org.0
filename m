Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513F32B934
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2019 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE0QlB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 May 2019 12:41:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35267 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0QlB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 May 2019 12:41:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so5896419qke.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 May 2019 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKyCzranttTm8XPWZ088AThg9Hdd7C67ToC8/YpFmsA=;
        b=JoXnXy8/tEruwLfqT68I0PkNoD1cUd9CL7ad86oPqCK6rLiNf/xJoYDiTBVLpt8Q8p
         Ma/XA/aqqIjPXD6wbPe2lDxoHnYHNhIpWNayaGl6UIGn8LP9CdRo2OO7bm0TyVFTKjlD
         PPm6skU32u13lfbHtntWF+heqdnsbsqiwIYaky0bYnzL/shrCN0Lz1Qt7m6TMthO2csj
         lynCL1SekUKP+mmafPD/TMcqSwtNL5hak7H+zimAeb/j3BlJ7HZoRWHqJgpG1vCKDT4f
         iwk/yVgfBK5hbk3aZy6NcHWDY648CG+ErIfzahLfiKcjB5qWGItSLVTy6gSCNIqdGALP
         0PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKyCzranttTm8XPWZ088AThg9Hdd7C67ToC8/YpFmsA=;
        b=lKbyHNG7JP8bcbK7tyGLpbESc7xRt19xyHkDzDKNxm/zjg0t5+lm1Udr/KV91d/VvT
         CqT+bJYzm6vxNPBSKLGDI7WeuCBWnIfWCS+J/9iM+dOzuRE8MXh5fPjkZaGv3I+Eiw9u
         KbsV9VbGHakXmPt/dZuWzvJAMwkPzsXzJhH1rzaXzKjPr2EOotCd7wQ6KPhay60JLckg
         jq8kn6LxZyUmlCDOkuRmDWxHTAIbPyhdFKzZ/TmAAxDznuBQAsF8hnmUDsbqi11G/j9m
         yTjU5QA4gAtMFq96MKHHBkhi2wkv03B62u2VeiDhmRP/aQKKgY9Zd5R3SgRGlxGT9hpV
         Rn1g==
X-Gm-Message-State: APjAAAWcut/Eo7qbCZvKTJ9/2VkDfILVhiU4vKfxYweit9ycgGwLpwR3
        4/G48Td0w86oqxQRzB1glSCNNgqwfnLdY0Tuj6SMmg==
X-Google-Smtp-Source: APXvYqxc8D6jRbqbUSRP+V6pb8JUYTalLP9nTD3wOFqlk7MMqBhgZQfadeI/9Z8WTKHyXATgVQUcB/fnlMdVFoDYbwA=
X-Received: by 2002:ac8:8b2:: with SMTP id v47mr60717451qth.80.1558975260447;
 Mon, 27 May 2019 09:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com>
 <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
 <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
 <CAB4CAwf26pdCY7FJA5H7d1aEY2xpjSto4JxARwczmVJ==41yng@mail.gmail.com>
 <CAD8Lp47K0Jn2wotANdQV3kT9yPP7bLnVd0eYhWui-vNDOEXBTA@mail.gmail.com> <CAB4CAwf7O9tyUwc+gPSZrBES+Bt7iTjhE1fbbVxYKqzjtmZBxw@mail.gmail.com>
In-Reply-To: <CAB4CAwf7O9tyUwc+gPSZrBES+Bt7iTjhE1fbbVxYKqzjtmZBxw@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 27 May 2019 10:40:49 -0600
Message-ID: <CAD8Lp45OtJG2V1F9Ybwav7RUs572Q88d2VF4YX1xjy=n5wsvEA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] rtl8xxxu: Add watchdog to update rate mask by
 signal strength
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 27, 2019 at 12:38 AM Chris Chiu <chiu@endlessm.com> wrote:
> The -EBUSY is returned by the ieee80211_check_combinations() in the
> ieee80211_check_concurrent_iface() function which is invoked each time
> doing ieee80211_open().
> The ieee80211_check_combinations() returns the -EBUSY because of
> cfg80211_check_combinations() will iterate all interfaces of different types
> then checks the combination is valid or not, which in this case the number
> of interface combination accumulated by cfg80211_iter_sum_ifcombos is 0
> when I'm trying to bring up the second station interface.

Thanks for clarifying. I see, rtl8xxxu does not provide any
iface_combinations so the default is to reject parallel interfaces.

Given that we can now confidently say that multiple interfaces are not
supported, I think that inside rtl8xxxu_add_interface() you could
store a pointer to the vif inside the rtl8xxxu_priv structure (and
clear it in rtl8xxxu_remove_interface). Plus for clarity, add a
comment pointing out that only a single interface is supported, and
make rtl8xxxu_add_interface() acually fail if we already had a
non-NULL pointer stored in the priv structure.

Then you can simplify the patch to remove the ugly storing of vif
inside rtl8xxxu_watchdog. You can store the delayed_work in the main
priv struct too, dropping rtl8xxxu_watchdog altogether.

Daniel
