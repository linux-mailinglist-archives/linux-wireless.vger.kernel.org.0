Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADCB435159
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJTRgK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 13:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhJTRgI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 13:36:08 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83373C06174E
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 10:33:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q129so10611737oib.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdaRz+/HIqoZ+D6ASe4LTEi6mTmOeWkSvY06s8Isgz0=;
        b=dxr9ZT1SPRYkdpGZIuvRMH2pBK3dL8EwUNYym6mFO4Zteaqbxx45lA4PG5/RqNnACG
         aqlkFhP6xgZ8zOz9Hw+Rg1pIdSF7d41jbaI+QJzqSgtDqI0lz3L+8cS3Vou1Q9ah4Qyt
         BJxnV7DRjHZvXSXYNOuhPXGh4Bnp17F2LUU2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdaRz+/HIqoZ+D6ASe4LTEi6mTmOeWkSvY06s8Isgz0=;
        b=OH1/uLMqTZSiLpiqz58rRK67FfGgIcR8iBy5NP6VWNlajTFxQiIa5RedIhUrfQ8sPL
         v2PwIatqN4/4+ha3GKCrxMqvIRrErjCT6ND3QYTaqM8SvMJ8FuduZTvft1mLgFrI1+Nz
         QMg7DnTdrpDqLHOeP+AYAtf0Dup+2xEBqkztHdXQL6LdkVx7heeaj81+T0nqSrkAY6DN
         3FR0LEmPmDni5vBfS0/sH1oGxvbwkz1jMt8y2/tchENmSayCBiXRoYYZbuvUM2uqsHif
         7V0m9oOu0ygRBKy06oxTR0NlunnNKzbVYPK86Ykhwe8VS11gJTa9KYLIudTr1WPg1RjE
         sJqg==
X-Gm-Message-State: AOAM532PV2yg78GMT7lg/ysQfKRmJnnoi+bZcGEgeElhRk7Y93mXfIMB
        H1G2kaQcMXL1xAzzxsk3rhW2gRjEpyWW6g==
X-Google-Smtp-Source: ABdhPJypxB+44sqRfa9Xxp8+RP0E8DwMqMVR1uFCrkrbZJmuN5I7Hwovi6vb/rqOVPJr+t8CHLBRpg==
X-Received: by 2002:aca:604:: with SMTP id 4mr683755oig.8.1634751232344;
        Wed, 20 Oct 2021 10:33:52 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id l16sm495010oos.44.2021.10.20.10.33.48
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 10:33:49 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r6so10546278oiw.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 10:33:48 -0700 (PDT)
X-Received: by 2002:a05:6808:1892:: with SMTP id bi18mr621637oib.105.1634751228418;
 Wed, 20 Oct 2021 10:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211020120345.2016045-1-wanghai38@huawei.com>
In-Reply-To: <20211020120345.2016045-1-wanghai38@huawei.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 20 Oct 2021 10:33:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNUY_HevQm12Q0MZrYzcbb7br94xO6fkuFi0EuzdV_LjQ@mail.gmail.com>
Message-ID: <CA+ASDXNUY_HevQm12Q0MZrYzcbb7br94xO6fkuFi0EuzdV_LjQ@mail.gmail.com>
Subject: Re: [PATCH v2 wireless-drivers 0/2] libertas: Fix some memory leak bugs
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, shenyang39@huawei.com,
        marcelo@kvack.org, linville@tuxdriver.com, luisca@cozybit.com,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 20, 2021 at 5:04 AM Wang Hai <wanghai38@huawei.com> wrote:
> This patchset fixes some memory leak bugs by adding the missing kfree().

You could probably just as well switch the kzalloc()'s to be
devm_kzalloc()'s, but either way works I guess.

Reviewed-by: Brian Norris <briannorris@chromium.org>
