Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB030B282
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBAWEh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 17:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhBAWEW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 17:04:22 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9D0C061756
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 14:03:42 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id h192so20597887oib.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Feb 2021 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B49gml/8cpgz8Os7F0PVegLTz0oYjIQVNIevIep8kh4=;
        b=Gh9nYVSmTAOkcwnoYC7iPOHwxtJA70Mk0Z650ygrrx6ADWq9ub7IYWOPuASCC9cfkR
         GNhMZJWnjvwu8PZuhQEAvjEz9dOe5j3dbaPZKcR1CsU4U6CZJNDNcG3q1TzPmIR7xT5+
         57Fg8AK0YFDpp5Gd6AIZUFWO5td0ItCu3ZNxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B49gml/8cpgz8Os7F0PVegLTz0oYjIQVNIevIep8kh4=;
        b=aXwJplMiN6b1r3bRxY6Zls9xoAQ2hyuMsA79mZ2YYSjVE7GNw9yM2FKUa0FynvzBBk
         bC1SLYiI3vwt5tUsSurYm9t49NhbV7aMz5e4qXdWGwkor544ZkkjHNZWcnOrfi6nnliT
         8WP7+U/UnPvDif33MFoGbMpcnO2oW9QA+8YW4jC6f+WZfDiq10tqd2511pvkAH40yjDW
         jPRfWRTHXmNIVjoL/AJ+QneWRWgYS6BD5xtwac24XgH//56iZtGCppYtdsBavnnEPZXC
         hS2fXguA/2gWAI1N0iFoHljj2IhLSGIRdGffkSjfqFXLEwvtAUCLXqc2R41/lJ6hYwWK
         j6/Q==
X-Gm-Message-State: AOAM532kEIFrRLF+D/JimLxSkKFLnopEGINqzjC0OflLGvtuMu6NmEWs
        59ZbMy5xwCkYGlUbcUKnPIHuCzkkbLfACQ==
X-Google-Smtp-Source: ABdhPJxNle1PoSvC0Ej8oTmpI/xcV6U/btXuoBFfLpagKvV0DC0l75W1f+Bqf+rTK79kovwCJnYqlw==
X-Received: by 2002:aca:5954:: with SMTP id n81mr659650oib.25.1612217022024;
        Mon, 01 Feb 2021 14:03:42 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id h18sm4268471otk.26.2021.02.01.14.03.39
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 14:03:40 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id j25so20622060oii.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Feb 2021 14:03:39 -0800 (PST)
X-Received: by 2002:aca:f40c:: with SMTP id s12mr622260oih.105.1612217018531;
 Mon, 01 Feb 2021 14:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20210201070649.1667209-1-yenlinlai@chromium.org>
In-Reply-To: <20210201070649.1667209-1-yenlinlai@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 1 Feb 2021 14:03:26 -0800
X-Gmail-Original-Message-ID: <CA+ASDXO-bVXhEJE+7kSe85e8i31kzACHeypt-8vBD2ZO2_1=3Q@mail.gmail.com>
Message-ID: <CA+ASDXO-bVXhEJE+7kSe85e8i31kzACHeypt-8vBD2ZO2_1=3Q@mail.gmail.com>
Subject: Re: [PATCH] mwifiex: Report connected BSS with cfg80211_connect_bss()
To:     Yen-lin Lai <yenlinlai@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 31, 2021 at 11:07 PM Yen-lin Lai <yenlinlai@chromium.org> wrote:
> When a network is moved or reconfigured on the different channel, there
> can be multiple BSSes with the same BSSID and SSID in scan result
> before the old one expires. Then, it can cause cfg80211_connect_result
> to map current_bss to a bss with the wrong channel.
>
> Let mwifiex_cfg80211_assoc return the selected BSS and then the caller
> can report it cfg80211_connect_bss.
>
> Signed-off-by: Yen-lin Lai <yenlinlai@chromium.org>

This seems sane to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
