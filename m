Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1E3E31C7
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 00:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbhHFWae (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245512AbhHFWad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 18:30:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65475C061798
        for <linux-wireless@vger.kernel.org>; Fri,  6 Aug 2021 15:30:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b1-20020a17090a8001b029017700de3903so13458499pjn.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Aug 2021 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=KzU0uWQel4rrqucZdeNEFegtyMHl2eu1JNNVShfFEqSIZQRwT9iIriyUSrEtpZic3k
         xGxqvfScDKAIukCjdhuRPVuxXq1bn5BBIFzAWjRZHxpKhDPQbRw8G6JLb+nhuFX04iXD
         dzpXkbjuO3UPaRbJ37MGU7vlcPgt8zRMN2W2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6t4R3/clPInEWqQYAYEqGtfb7Px8wNaCjYlpj80+2H8=;
        b=ad0AByyWrG79YlBkUrm3uYxde8iJwearJ3T0GYUYN2OA06UB64wAF5tqPQz5u6yLjT
         Wj0U+4DFrqBMejl4z4KWmu066Dk+TUwCkirsy1Q1Pcv4odGe9N2K+fzTSBwmoIPHyxHA
         ZmbVn2wQBpDBXlcWZPPiFSJ1C+2FpRJb6sA7wgwqZ1Yc2BvGmrpijZZjRxEbOqow2obP
         kyh+KV3LuuZ1Iy9XgHufGoFo2o5c5KZ7CXKaJReUQU62MqdlZb0OeIIEDlARMQtEjVwY
         fCfqiwr/n5Uab9PqOBZt8M3T1AmKP8QY327YcWl9CCwWys0KNMowSqHlwlY2acAzWrHl
         LZLw==
X-Gm-Message-State: AOAM532o8Y88rYjjJ7UdDBN8GXWpACsXK6KqAsDwY90mlKr8A/h48vxB
        FhyESPjb3rO5AwnXn4d1wc/r4xB6ETtI8g==
X-Google-Smtp-Source: ABdhPJzJNM8Y2Fq8MMmxSifX6jMF7S2TiaF1k771cOv/hwziioYA+1qaKgY1XfHH80q4W3Y3DA4Nvw==
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id z63-20020a6233420000b02903b763950a93mr6951533pfz.71.1628289015923;
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm4058945pfe.37.2021.08.06.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 15:30:15 -0700 (PDT)
Date:   Fri, 6 Aug 2021 15:30:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipw2x00: Avoid field-overflowing memcpy()
Message-ID: <202108061529.07216CBF7@keescook>
References: <20210806200855.2870554-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806200855.2870554-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 06, 2021 at 01:08:55PM -0700, Kees Cook wrote:
> -	if (element_info == NULL)
> +	if (!element_info || info_element || info_element->len != size - 2)
>  		return -1;
> -	if (info_element == NULL)
> -		return -1;

Gah, a let a typo in. (should be !info_element.) v2 coming...

-- 
Kees Cook
