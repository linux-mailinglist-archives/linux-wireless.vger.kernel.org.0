Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6572F530A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jan 2021 20:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbhAMTFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jan 2021 14:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbhAMTFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jan 2021 14:05:53 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ED3C061575
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jan 2021 11:05:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l207so3281702oib.4
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jan 2021 11:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3fA09py/40OlixsI/F8f6sBxbVt2+7TI6MlGgYkytMQ=;
        b=J1XRl7Gs/qvCRS5l9ulasgf3bmyBBklaLr41cPMU7vaPWbrKVIy47MVqRZ7K1mjs42
         YzsokCMhLcZ4+rf/ZXLXc6kXkzSeKe9Ja7oLfsAdml+P7mmYo2lMTu6TEuIZxEpeqjeS
         od/WKjvtVSnej1Y/uSOmHEwsoNWiMe1JzjF1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3fA09py/40OlixsI/F8f6sBxbVt2+7TI6MlGgYkytMQ=;
        b=Mf9tL2o4lQLcfdRclMD2Oc3mQWtYpsZ1opne3ZbFjyAZUZeir60UK4669CDt5CuMNI
         gzP8TVen/oUCag97qDvpleYYp/MHoZQ6+HPvga+fylGfbhiGmxZWRjQD9ve0H0ztDogZ
         FzYkMsXUmf3rTtyF/+7JnZamL+jmzSxgiBlFbyDjGSlOvbRtvrBAliMzKbkDIYdxjfUH
         YN49e6ayvukuVQL5V+s4OL6uKj2m8IWSRxPvVs0+R9tQvCZ9YkVZUAw9bF64VrGeXlTQ
         WoR8SCJIVFnZdKFVAE4kwDNqvPitq7vlsBh1n7L+xj0LNg1yh415qebv2OhdNwcadVhl
         OmXg==
X-Gm-Message-State: AOAM531NU1xJciB/vyTy7PLvEGe0UfuYzGVyZcSE8azggjxuKfVuw7Fl
        AVLnvlUCWXhCusbFDGQP3z8oUgNncTlx3A==
X-Google-Smtp-Source: ABdhPJzjKfTC/QNS/2qEtnYcihVt0wryrlbW3JRRjLOAZ9g4ysFL5GrV9MlCoTrvPe6eg7BDet1Atw==
X-Received: by 2002:aca:3145:: with SMTP id x66mr457258oix.29.1610564711903;
        Wed, 13 Jan 2021 11:05:11 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id c18sm572583oib.31.2021.01.13.11.05.10
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 11:05:10 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q25so3244662oij.10
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jan 2021 11:05:10 -0800 (PST)
X-Received: by 2002:aca:af4d:: with SMTP id y74mr430097oie.105.1610564709956;
 Wed, 13 Jan 2021 11:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20210113095101.16570-1-pkshih@realtek.com> <20210113095101.16570-5-pkshih@realtek.com>
In-Reply-To: <20210113095101.16570-5-pkshih@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 13 Jan 2021 11:04:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMZL-nWU=Wn=SQOQr6aSR2ntW15RbuUNvXLmH+q1q35nw@mail.gmail.com>
Message-ID: <CA+ASDXMZL-nWU=Wn=SQOQr6aSR2ntW15RbuUNvXLmH+q1q35nw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] rtw88: replace tx tasklet with tx work
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        phhuang@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 13, 2021 at 1:53 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
>
> From: Po-Hao Huang <phhuang@realtek.com>
>
> Move tx tasklet to thread, by this we can reduce time spent on
> waiting for schedule and have better efficiency.
>
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

I'm curious, why a bare kthread and not just a (WQ_HIGHPRI?)
workqueue? It seems like you're sort of reimplementing some of the
workqueue semantics with your SCHEDULED and RUNNING flags, when
queue_work() would do that for you.

Brian
