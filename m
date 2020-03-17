Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E65187E9A
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 11:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgCQKqd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 06:46:33 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41350 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQKqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 06:46:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id b17so6232260oic.8
        for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2020 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdGwLrwNJVDuHZvvQQ7o6KAi1K5yrwhUhx/4ly7EpxY=;
        b=0asw0SApftOnYJuL8k58n30deisQlSeUxQdW5clNZe/P+162Hv00jdRXZoO6aklAoZ
         5l/kL+WPrIowMswM6L5mrJiEw9YKIEGnli0jPnEjmfSRppHzbJBRA8wpS+YCrF7JfnZo
         KZZpcbUUP2pHpJjRCvl33a7nwNW5w+ohhxjJV0jVwOMpNjdlMc0M0nFyA3xPpaJYeqtI
         FG87PM4p8bn98UZrCUNHunIvTnfM5OhwkRzX0ZahOrGjJxlPMZGzf5s/mChCGUvRW6pe
         Bn3565NsQq2lz4je9cRvYJ+5QVi33Sa7P0ISgWOBsHoWlL+F34NAHN8IgJweJZqR5xwA
         QfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdGwLrwNJVDuHZvvQQ7o6KAi1K5yrwhUhx/4ly7EpxY=;
        b=lTpMbQGj+Z8KZ/ZAoqQimF36WcI3Obn0TPkFf3oPNo/cq1smDHM3pc9vqXQoC5IrAL
         gd/Wk0AMNrja4eteMA2UKEDUZ8awjRC+wfOH0ZDifuuc4TMZGCUOrW5H5ZEk5gTMsb6N
         HSJLz9/B/XWuc6DE9VmOY1kwwxyixsqrAn9ztrcheG1Q0SNZHJ6blHi3FwHevtk4kHYJ
         BfYPni5+fJpjAqK7PcgnpGUf3det0E71rltNsGrZiKKj8qAIEmypYHtiRM/A3h4umvY0
         Lir0uuGARyRF/8QibewhSXqBaOU76kiTZ1DpLGa7X3aPuXCE8fGgCui7w3IKlDWgBr+N
         W/rw==
X-Gm-Message-State: ANhLgQ2YL0yGsHOl4jsjDzCDYEzFFfwcvsbuj15/idGUHYPpcrsMD/Sh
        CUrGsVNmltL77XKOil580N2FiraH54uYgSuBbBCBnw==
X-Google-Smtp-Source: ADFU+vs24v9wVmKXF57oWpAQ14JjBOKRu0OW/f8b3KbzKqja+p/QyrEmZ8l1LwKVoMPkoRznP9SxXLosS78ECQHuGl0=
X-Received: by 2002:aca:c6ca:: with SMTP id w193mr2844227oif.165.1584441991996;
 Tue, 17 Mar 2020 03:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200313033008.20070-1-yhchuang@realtek.com> <20200313033008.20070-2-yhchuang@realtek.com>
In-Reply-To: <20200313033008.20070-2-yhchuang@realtek.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 17 Mar 2020 18:46:20 +0800
Message-ID: <CAB4CAwfxM8fVjK_UOKHvA5RfGJ10fYfZWygkQFFyM80m4NutwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rtw88: add a debugfs entry to dump coex's info
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        arend.vanspriel@broadcom.com, tamizhr@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 13, 2020 at 11:30 AM <yhchuang@realtek.com> wrote:
>
> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> Add a new entry "coex_info" in debugfs to dump coex's states for
> us to debug on coex's issues.
>
> The basic concept for co-existence (coex, usually for WiFi + BT)
> is to decide a strategy based on the current status of WiFi and
> BT. So, it means the WiFi driver requires to gather information
> from BT side and choose a strategy (TDMA/table/HW settings).
>
> Althrough we can easily check the current status of WiFi, e.g.,
> from kernel log or just dump the hardware registers, it is still
> very difficult for us to gather so many different types of WiFi
> states (such as RFE config, antenna, channel/band, TRX, Power
> save). Also we will need BT's information that is stored in
> "struct rtw_coex". So it is necessary for us to have a debugfs
> that can dump all of the WiFi/BT information required.
>
> Note that to debug on coex related issues, we usually need a
> longer period of time of coex_info dump every 2 seconds (for
> example, 30 secs, so we should have 15 times of coex_info's
> dump).
>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> ---
Reviewed-by: Chris Chiu <chiu@endlessm.com>
>
> v1 -> v2
>   * don't ignore "ignore wlan command"
>
> v2 -> v3
>   * use scnprintf() instead of snprintf()
>   * enclose debug only static functions within CONFIG_RTW88_DEBUGFS
>
>  drivers/net/wireless/realtek/rtw88/coex.c     | 492 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/coex.h     |  10 +
>  drivers/net/wireless/realtek/rtw88/debug.c    |  17 +
>  drivers/net/wireless/realtek/rtw88/main.h     |  18 +
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  30 ++
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  28 +
>  6 files changed, 595 insertions(+)
>
> --
> 2.17.1
>
