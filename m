Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C6335E875
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345155AbhDMVm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 17:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbhDMVm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 17:42:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76DC061574
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 14:42:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id p6so11138412wrn.9
        for <linux-wireless@vger.kernel.org>; Tue, 13 Apr 2021 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asPeWeAMicCNLTo4UoLiANMALEWnXXwF6JKij7XY6Go=;
        b=HQYWlwiMVOeGuq3qFYF7GpcoJeRfKPGcYkqefnT4WsarWPt9nz6QmC2gsaSCll4uU5
         ekBQPRPiIpAxuzBPwLG4966QO0YJgkMJCB6uR0X3KrwkvXdx43/f6XdJjL+wZysrhDJC
         q+f8CqR75yjdSSyuFtZUNBcJRnVJJbngIor6y5TPiahSOZHmCv/pAs1Wb/xHChkWG2WZ
         XYuLlXnXIS5YWHnsYDNle4scGofNOjrRyoM8+ti+YehdJtG+4WSrNpPLOgvzS26arRau
         YaTMmF5DOnRX7xzEg6Q4do9A7lTvkzYljbjtvt3kCzD26teJ7hnnYpYqcfZfdhViuGA7
         Mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asPeWeAMicCNLTo4UoLiANMALEWnXXwF6JKij7XY6Go=;
        b=FaafykLhi8XPa2zc2mawp3cgIj9Ct2OaFe/HVlPZrMckkLbeYKO5ed+g5W7wG+bpaT
         M2g5buo1zsJ2ShaWLOZet+FtlFjvIdsRosDKlv0KTfGkQyljBIlGZqHuVofeHzSddBGR
         B7w11u/FJIFTyfjzMJOXJqMPBav/tWWOtQ0IjbL45U2UTkP2wen6FoGgJ9mqqQSuG68f
         9Hh9GMhJQ2u6Np7wCrXBAYs64hX5ogveuRRWpIfvQMbYABlegkFdGxn+V4d0vywBY7OV
         oQab2LK6xHxiHKh17r5OB8/FyV/0o5ElpJftVIcBkaWlZGe4LmrMXv6Uv8neECZNDF4D
         WC7g==
X-Gm-Message-State: AOAM531hoykApX3+K2rJpoyND5EDYPxjcDtB8dZnXx2VjwSB0R+IyIdI
        1ta3ry++wlI5iQhgYwEOsRtysLIoQmr6xxi3OJxyFUcQyWE827fN
X-Google-Smtp-Source: ABdhPJw1Y74XekXg7DjCVCWGtzk8acj8NzmYcGz76OnYfiFVdoOozeXZfbD2SFFCb9Ik3UOstYueh7x+L+wQjQNsOMY=
X-Received: by 2002:adf:bbd2:: with SMTP id z18mr14779243wrg.274.1618350155438;
 Tue, 13 Apr 2021 14:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <9fafe866-6ff6-d1c4-0a04-493d863bc9db@redhat.com> <CAJCQCtRFqmioneenXeNEoBXnjGCrOeU-SthZKT60bQoMD84K2w@mail.gmail.com>
In-Reply-To: <CAJCQCtRFqmioneenXeNEoBXnjGCrOeU-SthZKT60bQoMD84K2w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 13 Apr 2021 15:42:19 -0600
Message-ID: <CAJCQCtSX4Laxr5pLbG-drBkb4bU+pTrZ+r00A5a1NceZfkH1PQ@mail.gmail.com>
Subject: Re: iwlwifi Lockdep warning with 5.12-rc4 on 8086:02f0 (Comet Lake
 PCH-LP CNVi WiFi)
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Luca Coelho <luciano.coelho@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 13, 2021 at 3:38 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Looks like this:
> https://lore.kernel.org/linux-wireless/nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm/
>
> I tested that patch on rc6 and it worked so far.

My original report here:
https://lore.kernel.org/linux-wireless/CAJCQCtRuZ0hACdwH1N23OZrxEVyM2W9gn_O4wZRcFSq_74Gkqg@mail.gmail.com/


-- 
Chris Murphy
