Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE06E465BC8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 02:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346416AbhLBBqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 20:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344264AbhLBBqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 20:46:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58977C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 17:43:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so56333825wra.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Dec 2021 17:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUHJxgm31kZ5HlHTPWQ2dagOtbXRFGWbUyccHHiAAUk=;
        b=jRJN+INEefaPfDOYf6payOCZs3DGCSuk1WZw502uVs05KIbtFXlBPQSh10QdCGPpUK
         FDcUEcP2EaK3ylJfUqckZAhqlgiEnPYWueF26jZG5yn3EYCHx9stoTrAXbzn7lvg53cP
         0JiL+JKaXR8WeBdvFeHgyxmf1apdHm1kf9CQC+Omh5c1G76Z07CBjocaYRXbopZue37a
         A9FiZuyTHyee1qSNUqNzepoYMqtYYB4/YLi+3S9V0F4Bk+0OfYeHtvnUm6VS1o929rcD
         /CAdlbnw/lKm+gvO16S3K/3/dTh2K8x3VD1IbrGjHD3ruG9IaV5OlCWviJ6O7gnXxmZa
         w6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUHJxgm31kZ5HlHTPWQ2dagOtbXRFGWbUyccHHiAAUk=;
        b=tLFUX4Uh9T+vrSsu2roBn9Om2KQKtW3CC4rKI3EhOXf5LDAXn0nI+FsVUaPGy3kCC6
         z55MHNlkz6r/wP9WYM0izOFIhdQeK1S0GbESYV53qUnQ4JajuOYeOTy9ivrZxCR5x9I4
         1NWXWkDART9/2p7QFGPV7SXyD6D62DxqNmeBvHkJytb/rbalUSK2YH/OcgWmElHyxOqg
         M9qrrjtdbm+HHY1YWjJXJU9Bx98eLXBespt/4ex4TW6XeelXtv/hhRnTXeamSmCRK6YE
         sR2HlXzoE4uMcjGd8LHNX8L919L0q8nswbwNoUK465CREv6xOdOBaYDbRaA17iXIdF0E
         Qq7Q==
X-Gm-Message-State: AOAM533qRGILa/xIZJn21NwxrweKXAsD2NcbwMSZFVlFeHJAq7NZUhj5
        aXjhpg4uemcvrKECCIxkmhulGK8938VferxOxc4E4XKPXMBbYA==
X-Google-Smtp-Source: ABdhPJyJJf8PPy8acKX8Qp17K7hiepUPb5rbheUah3CdxJyqHcrPEJ6kRHWrZLeQx8iFpTbLQE83lNbD6yAO1IC0Ol4=
X-Received: by 2002:a5d:6508:: with SMTP id x8mr10593847wru.388.1638409403614;
 Wed, 01 Dec 2021 17:43:23 -0800 (PST)
MIME-Version: 1.0
References: <CACJOGMP0k1AH9Coz2DjZjkeoxPGjSyP60MYMSHrMN-hSJrrvTQ@mail.gmail.com>
 <74887ec8f49846f5ae8b40b4c213d2da@realtek.com> <CACJOGMOBaQ+vc37dnpS8JYEnE4v4bufSkw+_Or5FEzkTiKXfBQ@mail.gmail.com>
 <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net>
In-Reply-To: <5dc56416-7564-6a11-d477-9841b27a7123@lwfinger.net>
From:   Jeff Clay <jeffclay@gmail.com>
Date:   Wed, 1 Dec 2021 19:42:47 -0600
Message-ID: <CACJOGMPDY5C7y=+WVJcOUiF8i58pdoZe-FEWLqO1OrCG-8hTwQ@mail.gmail.com>
Subject: Re: Latency spikes in rtw89
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Setting "options rtw89core disable_ps_mode=Y" in
/etc/modprobe.d/rtw89.conf didn't help.

On Wed, Dec 1, 2021 at 11:39 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> On 12/1/21 08:48, Jeff Clay wrote:
> > Thank you for the information. Would the issue persist if I were to
> > disable wireless power management?
>
> That is an easy experiment to try. Use the "disable_ps_mode=y' module option for
> rtw89core.
>
> Larry
>
