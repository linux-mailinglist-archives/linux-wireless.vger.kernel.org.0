Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF29C66175
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfGKWFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 18:05:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33450 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfGKWFx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 18:05:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so7354469ljg.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2019 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD2ywJIPeinUw5E9fc6j8ZzoAMc7kstGSVhGV8PrPAU=;
        b=DdpJQGZwMGFOHsPWBkpYWS/ovNyi70mFYHpyUvM4lg79BuSR5EhbQtAxS+zVdrMz99
         EhMB7u8hzLuN5YzsA8SuTtMCOsWwd2RLZgTNHFV4QqYl5KtCKqjGkGkt6hGWiJ2hsEaN
         lX4YDRHaGijPIUffJhU20aeIp0PM9E0+MvL8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD2ywJIPeinUw5E9fc6j8ZzoAMc7kstGSVhGV8PrPAU=;
        b=GSNYL6pxQmRuEsgy3ap+yDVX0BUukx2u5gmqM/VLtgAvFYc2VbvxPXan/JuxGsEA6V
         B+y4kpuvH/NT3Z9mSt6OhtG3N+dvjQf6Dczby4LoMyPU3XUZSsRGsmVEOpG8+cW5G1w5
         FTjIg09PyE84SN0PrB+gjHf3ZTF1m7tePgoRoZgxtabD8SJhhG7Uh7rZ5QUEk1Qu5DmE
         y4Bdc2J5X7muBWkr7pNP+inmYDfR6/b6haggQM7zSdzEi56vd29Ss7SQw+M8HfOrTD6n
         b2RDzAA1ul2yhQn3T2Gop6BIMK6hrPvwpuEy2QmlWg0YBTqbxUfYzmV25duus31BeNYh
         xvNQ==
X-Gm-Message-State: APjAAAU9QfRikgIoLXFxZ56OxakDOppjOhdOHSHUaw0gZGB2vi2NaVHZ
        FjFTgEskH/z5QwlGtoxpDAUk3RJGShk=
X-Google-Smtp-Source: APXvYqzclfdtwUBeN9FGx70otpQpqWQ0Wj9syxweNwuc7XiM4YU2mYdRP3Q4qbvXeoonbMiyPYoOjw==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr3921170ljj.58.1562882750674;
        Thu, 11 Jul 2019 15:05:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id u13sm873328lfu.37.2019.07.11.15.05.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 15:05:49 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h10so7354402ljg.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2019 15:05:49 -0700 (PDT)
X-Received: by 2002:a2e:2b01:: with SMTP id q1mr3797286lje.27.1562882749331;
 Thu, 11 Jul 2019 15:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <1559116487-5244-1-git-send-email-yhchuang@realtek.com> <1559116487-5244-10-git-send-email-yhchuang@realtek.com>
In-Reply-To: <1559116487-5244-10-git-send-email-yhchuang@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 11 Jul 2019 15:05:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMWYhORB7=bCh84BO1wuPdAa7dpTSyTWuUYzanfTYA=Pw@mail.gmail.com>
Message-ID: <CA+ASDXMWYhORB7=bCh84BO1wuPdAa7dpTSyTWuUYzanfTYA=Pw@mail.gmail.com>
Subject: Re: [PATCH 09/11] rtw88: remove all RTW_MAX_POWER_INDEX macro
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I realize this is already upstream, but I thought I'd ask here, since
I was going back and reviewing some of this:

On Wed, May 29, 2019 at 12:55 AM <yhchuang@realtek.com> wrote:
>
> From: Tzu-En Huang <tehuang@realtek.com>
>
> Since this macro definition has different values in different chipset,
> the current defined macro value is for 8822b. This will cause the
> settings of 8822c be incorrect.

^^ Is this actually correct, that 8822b was correct and 8822c was
wrong? Because I see RTW_MAX_POWER_INDEX used to be defined as 0x7f,
and rtw8822c_hw_spec.max_power_index also appears to be 0x7f. Which
would sound like 8822b (*b*, not c) was wrong, as it lists 0x3f.

Anyway, I'm going to assume you got the change right, and you just
mis-spoke in the description.

Regards,
Brian

> Remove RTW_MAX_POWER_INDEX and use max_power_index in struct rtw_chip_info
> to make sure the value of different chipset is right.
>
> Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
