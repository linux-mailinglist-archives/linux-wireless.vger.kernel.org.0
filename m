Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DA23F43FD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 05:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhHWDoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 23:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhHWDoM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 23:44:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72095C061575
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 20:43:30 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i28so28942569ljm.7
        for <linux-wireless@vger.kernel.org>; Sun, 22 Aug 2021 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+kO8cACxV1hGUhU+uZ+UzjwiVeQ01EgXhWkMN0cp4k=;
        b=a5EJWuZ1xp1wIGP7MaODC/tnvLrkP9EJPGZdGRmmeHVM9weNjGqYvAI3nwEz3VPLda
         x+UJsasKWuCXrwbvoCuImod9s3wBo1XJJICCnXcQxGhtlpsj/BlDt0JsuLh/sK0PZeH5
         2g5xn284wUjaDgyRKotQIolWTu1qvXrGxCjUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+kO8cACxV1hGUhU+uZ+UzjwiVeQ01EgXhWkMN0cp4k=;
        b=sDzugnciXhiA5LsIMxrj2m94btZNPYywYJN+ydVTnwuFwJXeZUg1i1ElHXhOgTN+DS
         XLP8fGSup3r2H4KlEv7Kqegpuosv931x99/K3SUSISH/RL2zH62WuxMv7L9U9tG9dVfp
         1TKbQ2wqmK9WgU+l+HNdIYH72cwBAolwd0rnONlKFWFcRQdnxL/I4cBBdyo4wlZ4+Ywt
         JgY0skkO3Cw/VKVKd+ZhU1zVWFCVX+9QuK5LYQySVXe1w/bi2gHzbueIyVlxv0md28dT
         YWKz3OwfubsT9tzG9pV4flv/K8exMSr+nA/V3BND7JmgV0MhXMaOwV9NS6MYolSuSJXF
         JhWQ==
X-Gm-Message-State: AOAM530oNBK2qzAsqoppQBTuYum7u4uToTjk2JdvU49YJfHAkCP9Jk52
        hhM4MHE5iuFFWzn76vqTaqPUq45UfPYR1lItBHqFFQ==
X-Google-Smtp-Source: ABdhPJynIguZSKYAjluYqnNxeBU/MBr3PM4KE0nI1vXFNbRZPTwNnZY6dfxflnnSmS77TpNiGlbeDMGchMc6oxzS+bQ=
X-Received: by 2002:a05:651c:1785:: with SMTP id bn5mr26594332ljb.18.1629690208875;
 Sun, 22 Aug 2021 20:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <9c71befbdf8a97f72f4538c39a71041ccffbaf83.1629685207.git.objelf@gmail.com>
In-Reply-To: <9c71befbdf8a97f72f4538c39a71041ccffbaf83.1629685207.git.objelf@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 Aug 2021 11:43:17 +0800
Message-ID: <CAGXv+5EYBKeDKWUbO2GWbYujwyiBg6b0=PUJENXdMGfXeGWvxA@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt7921: fix the inconsistent state between bind and unbind
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com,
        linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 23, 2021 at 10:27 AM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> We shouldn't put back the device into fw own state after wifi reset at
> driver unbind stage to fix the following error because that is not the
> consistent state the current driver bind stage expects.
>
> localhost ~ # echo 0000:01:00.0 > /sys/bus/pci/drivers/mt7921e/unbind
> localhost ~ # echo 0000:01:00.0 > /sys/bus/pci/drivers/mt7921e/bind
> ...
> [  481.172969] mt7921e 0000:01:00.0: ASIC revision: feed0000
> [  482.133547] mt7921e: probe of 0000:01:00.0 failed with error -110
> -bash: echo: write error: No such device
>
> Fixes: c1af184ba830 ("mt76: mt7921: fix dma hang in rmmod")
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
