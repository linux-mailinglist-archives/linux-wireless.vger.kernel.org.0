Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787D3FAD8E
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Aug 2021 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhH2R51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Aug 2021 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhH2R50 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Aug 2021 13:57:26 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BD9C061575
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 10:56:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f2so21749937ljn.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Aug 2021 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1Y80Vw8sw5liCLYQx1o6b086zpBifZuJM9UGKAOns8=;
        b=sxmComzQ6uhH27beJgztFWBAq9CGMSvsnBxyhmT2NG+nzoISSuz+w3UFlX6MZz3kgI
         SLDUNbNSOaV5dFZWp6sjesd2yW9cJ42aU98Q1okuHWfnRvCW8DcO2qaAo8axoaNCIblX
         aaKE4/kAtc/QCjnwxQEw10nJB4mi9BUcg00Lxuc5wl8tvTRdHFkPlggCF0I/vRcPJ+3l
         IEmN+Z6QOS2BdS+JhSiXSdA96qFjAPoChob4u4MYVp93F/GYLeSW45Mg3Sxht7LEEDU5
         hw7ue3FrM8n3wZnp9E/oTnPgiMrffDICfRdA8vAEFWzmpeV6GQtW5U8d7s0VtTl+JkEb
         tWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1Y80Vw8sw5liCLYQx1o6b086zpBifZuJM9UGKAOns8=;
        b=GjPB4kJYl4sxsazleNWy1cczgIW81pfa8vnYIQWFjt9WZcTR5qUAbLPAHCDSf+yYyQ
         /rwcfFRbKqmvKia0CMewOp6mcoJI6DNyEXsUqyVE8Ner0yXM8syIXfVxKr25C9vfUKEJ
         WRUue/DgqpEbCw4ShRJFuNZxbogONNMFvnZ3ykaA2dWXpI0nqyE8W9PP4JQkfq98+aV+
         hTkIOm3HjJ4OjYTHBohPdIk/r+rc10cpuW7WLKK5eDAMO2hkFgzJpiXuYM/BBqyQhODX
         DDanf+Gp/T1oWJXDWVHDEBLWqrTGZv39XgO27KD8PzHIHiRphyJ6CI/+JhzPv6GguxPC
         ZkDg==
X-Gm-Message-State: AOAM530DqWcMu8TyEW8YeQ0Xz4ni/k5+PIaLN4GHeE3zIzWioGxLv9TO
        c9Hsn4Tu4gkXkT7iM0tE7nZwa2du4IWuiLt48MXYkN0N
X-Google-Smtp-Source: ABdhPJw8sXm8FKHXK8gP1CAUH7xR4cmYW55krqXu1AMrMMXA/XFiUviVJ8ytKodR11oP6Uaoqy4sg2vu+TqGB8gV1fU=
X-Received: by 2002:a2e:3914:: with SMTP id g20mr17095204lja.88.1630259792468;
 Sun, 29 Aug 2021 10:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <a0464631-22f3-be43-a7cd-7623bdc640e8@candelatech.com>
In-Reply-To: <a0464631-22f3-be43-a7cd-7623bdc640e8@candelatech.com>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Sun, 29 Aug 2021 19:56:20 +0200
Message-ID: <CAFED-j=FGHJv+NQZMfN+xEfNB9L51EeU+-1BKjcZ0kX-K925nw@mail.gmail.com>
Subject: Re: CAC question: DFS -> non-dfs -> DFS
To:     Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

pt., 20 sie 2021 o 18:45 Ben Greear <greearb@candelatech.com> napisa=C5=82(=
a):
>
> Hello,
>
> While poking at the MTK driver and trying to fix some CAC bugs in it,
> I noticed the following:
>
> Select ch 100, which enables DFS CAC logic.  Wait for that to finish.
> Then select CH 36 (disable DFS)
> Then select ch 100 again, and the chandef->chan->dfs_state is set back to=
 0
> which I think means we must do CAC again.
>
> I was expecting in this case that the DFS state would be set to NL80211_D=
FS_AVAILABLE
> instead, since CAC just passed a few minutes prior?
>

This depends on DFS region (country).
EU allow preCAC - once you pass CAC then you can switch to other
channel and - the old one will be DFS_AVAILABLE - no need to do CAC
again.
All other regions don't allow preCAC - so each channel switch will
clear DFS_AVAILABLE and require CAC again.

BR
Janusz
