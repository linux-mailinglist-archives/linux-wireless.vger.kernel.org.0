Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05717156031
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 21:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGUxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 15:53:40 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43916 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUxk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 15:53:40 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so420074qtj.10
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 12:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pujW8/4AJugw2pHHXAsw2ZhP4vwZh/wLfhnKnw780uI=;
        b=I706I18OkWKTVuuNLujRuTmyOd//DPAixq4EJgfZqXCXYdQxw70L1KiyDJTCtw4OAe
         JePHgIvv715JZVwXEbEwezkw/duVpJH3zJ63xbN6ZkqGpitk196ZmIst/qp5bN1Zthjf
         8dKQhgZagxZtXJBz4vHdR1x96gSPe34rsbZzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pujW8/4AJugw2pHHXAsw2ZhP4vwZh/wLfhnKnw780uI=;
        b=rLGgouhGg3lo1LNAZcrllkx6zJId7muaDGjqOpArV9HlNKTMi+ZQSiqxKHUU27nUTX
         wIduaCWPoO376ZG1Aslqz/u8BKfL9+TXP6wnQQkhcKLOF6OocmHD5PZisGOX7JWO9Eed
         LveV753470Xj+4VrF9vruUjqtCOuaTzkkTjrAs71Dvb1SQ0wTyoUuX1FD9laM8hEutx6
         mzpWREXPUi1KiuFura5+aA+2+Kyqe9U93K9aiRxz2lGilpcJW17qW8YB2ZHlSib9E/xo
         3iu5fsZ6+hRYINemQ/CnednvnB2qGWKB2rPOa9etzTAmDvW98qR2l1NdnH18ZNjwdSJc
         nIEQ==
X-Gm-Message-State: APjAAAXtQSxiZlcCC8WJb26xuu870Bw0u9k8383LdThmazD93+crjNHv
        bt7ZRvlIwUSDyzXRviSbvKwHMrB9G4A=
X-Google-Smtp-Source: APXvYqwMHeounXATSkB8Xyrx5ykgrYJvl1N0YDbYnw+cv45Nod2s4zHLa4tRiuLDucWOORHUyaxsTQ==
X-Received: by 2002:aed:2584:: with SMTP id x4mr200295qtc.343.1581108819282;
        Fri, 07 Feb 2020 12:53:39 -0800 (PST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id a141sm1262331qkb.50.2020.02.07.12.53.38
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 12:53:38 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id x1so427891qkl.12
        for <linux-wireless@vger.kernel.org>; Fri, 07 Feb 2020 12:53:38 -0800 (PST)
X-Received: by 2002:a05:620a:5b:: with SMTP id t27mr698902qkt.221.1581108817962;
 Fri, 07 Feb 2020 12:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20200204120614.28861-1-yhchuang@realtek.com> <CAB4CAwdFez_WbRQb2jZQtqspSkO5ujL31ZLt4XshNcWiSqHByA@mail.gmail.com>
 <CAMrEMU_KJbwAK-onH0sRUgUPxDuZtD5bPJN6XmF=a9NqpfeJ+g@mail.gmail.com>
 <CA+ASDXPHWNN+TvrJFi_6w+ep_TBtLJ0refKenNb0tc8Vs+YjgQ@mail.gmail.com> <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
In-Reply-To: <CAMrEMU93LScySw4mpidAC5pVHV_NOShP1_GMMsvsAk1QBhdJjQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 7 Feb 2020 12:53:26 -0800
X-Gmail-Original-Message-ID: <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
Message-ID: <CA+ASDXPHXFquF2iXvdxZXhkkLPndkACgenLJwMR_9ON7zZZM3w@mail.gmail.com>
Subject: Re: [PATCH] rtw88: disable TX-AMSDU on 2.4G band
To:     Justin Capella <justincapella@gmail.com>
Cc:     Chris Chiu <chiu@endlessm.com>, Tony Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 7, 2020 at 12:48 PM Justin Capella <justincapella@gmail.com> wrote:
> I understand, I'm suggesting disable by default but option to re-enable

Ah, OK. Seems reasonable, I suppose, although I don't recall Kalle
having a particularly-high opinion of module parameters for tweaking
core 802.11 protocol behaviors.

Brian
