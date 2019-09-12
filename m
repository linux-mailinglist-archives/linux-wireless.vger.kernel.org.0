Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB03CB1093
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbfILOCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 10:02:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33857 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732297AbfILOCx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 10:02:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id j1so16961385qth.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Sep 2019 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n90yZxJuFn/P2yV9U4wP1BsuAX9RAT3gtP/Ag3qa1Ms=;
        b=gEaD+BLFJDBDctu4O44cmuNr/6TwifIRuLbLCXrLL1GBGtVyVPIv8x2cPjJpOQmter
         S4G/f2ebFZLWlaZWFv0VkLgf1z6RPUOMjUv/PDsmUnlvTPy0rt2qAoVw2zpGz3TyRKKl
         3FWCz4DNBoW9/5IDuP9qpa4W/7Y9Vo7vgY+KM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n90yZxJuFn/P2yV9U4wP1BsuAX9RAT3gtP/Ag3qa1Ms=;
        b=kQ6Nh0LvsRKF2gueRhs+qTVVe4RiigHsDsrLTk8z5pe4iD/XRH+TCFttk9DK/44Gwd
         HHnSCZgsuVvDl59X32Vb0kOG9RQaUPLZ1L3x9VIQggyouKjM1nJHsRw4MV4jo07DbSIn
         ZKtro6DjcV9J3DWmhA3E8bx41DjbtYwvLe5P+w447oMhrx9rZH/UvMwcIvp4Gmh9gzVP
         5u3POtIjN9589iKUOGdqbPXqfZiwPgOL6VH5eFCl/zXhxyuAwoU97M55hKX8K3seo1hi
         X71vUhOiyODx/dLp+XisyQJYcY5P2kF7Bpy2qc3BRevKIT4XKXGPadC1/7a4IszTeJTF
         t+fw==
X-Gm-Message-State: APjAAAVvShcuK7JJXorbC6oc22cjyZzp8dRFiUU2mcQwYD8pk3B4Pe4O
        ssyI3w+Zx7Sn+7dDxEOKIkI3dwGOw9wTPHIGv4gsAw==
X-Google-Smtp-Source: APXvYqwr6xn++fubxEcQE9iCc6eLYMMHQwbv8MMGjujGJIQ+ynDzp+pDHax/jMNw8pUZetWBIifGViJXBAbU59W9JkU=
X-Received: by 2002:ac8:2732:: with SMTP id g47mr34855592qtg.221.1568296972480;
 Thu, 12 Sep 2019 07:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <1567679893-14029-2-git-send-email-wgong@codeaurora.org> <87muf9k4pq.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87muf9k4pq.fsf@kamboji.qca.qualcomm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 12 Sep 2019 22:02:41 +0800
Message-ID: <CANMq1KDWN3NAuNh98QTgELqetyGQEGOkz90xeRNi74d==gU6Tg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 12, 2019 at 9:46 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Wen Gong <wgong@codeaurora.org> writes:
>
> > From: Nicolas Boichat <drinkcat@chromium.org>
> [...]
>
> I simplified the error handling in this function to follow the ath10k
> style, please check carefully that I didn't create any bugs:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e4d2cc5

Thanks, that looks right.

> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
