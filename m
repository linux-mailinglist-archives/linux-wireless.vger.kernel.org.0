Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836462BB514
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 20:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgKTTSU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 14:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgKTTSU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 14:18:20 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADC8C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 11:18:20 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t37so8035238pga.7
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/i9Wp3NyJ2XAt6V6C9rMEOf56CSMVPqB9lvPKpuPC6o=;
        b=A6bz8MoKhMEpf6tg+2HvalqvDlw1xmOxSg1SO4BbPffCb035fRyi6HeSG7U7LvQT7l
         xYU+VK7bi8OvfoYUaobXKHp+XtF4j5Voevd9nX72QgtS+cF68Aox8idwsVnML4uYmsyb
         SZCSt5TLA33olgVKwrlwIfeZ9z5z8JQ/GSR2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/i9Wp3NyJ2XAt6V6C9rMEOf56CSMVPqB9lvPKpuPC6o=;
        b=JRLGE7x2s3rsFedw7z48WuHpyJiaNBOxnxJ+6AOwtD1aLp1C1xcuVnEKATZ8COi8ur
         EoiS7EqUhnWbW5P/M+saeur5aJp8bDyjlRva4hlhFqBZFvnZ2A4POaHiNl3WQ5Us8+M9
         vGKIJdpcSs2Tq0xyXFT2VeBLT8hL/UuV6LnSAlyPijY2p2xcjcU+PG/jJNUvZYkKFl/r
         +JSk3VlVaAq/B3g3QVxelBoUxI8ss2rcfd/k6A9Hx4xzfUfpOL3Nkmbkfe6OSvs9tdbN
         tdsUoAppEZyVWzYdaH3sTUi9DckZPNY7MJyurM1NYHjSFYRWscolA7SZm7u7UpOMUtUo
         7tMQ==
X-Gm-Message-State: AOAM532vmVGjPr+eHD6ANpUJCRmQ89lrYQQk5dRRimeqkhtKZk0+mudJ
        BdiiTycs/PFYuI0/D7//J7Adcw==
X-Google-Smtp-Source: ABdhPJznhQs1XspFf53XI5p/EZOAG/c4T0kD/aTaNNbMtCtrqvJ764hFSBr91h1gUzYPJVGuU5VyXQ==
X-Received: by 2002:a63:e41:: with SMTP id 1mr17848400pgo.195.1605899899003;
        Fri, 20 Nov 2020 11:18:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm3933626pgi.70.2020.11.20.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:18:17 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:18:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH net] cfg80211: fix callback type mismatches in wext-compat
Message-ID: <202011201118.8F1A488@keescook>
References: <20201117205902.405316-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117205902.405316-1-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 17, 2020 at 12:59:02PM -0800, Sami Tolvanen wrote:
> Instead of casting callback functions to type iw_handler, which trips
> indirect call checking with Clang's Control-Flow Integrity (CFI), add
> stub functions with the correct function type for the callbacks.
> 
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
