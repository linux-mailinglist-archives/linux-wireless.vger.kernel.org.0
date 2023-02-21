Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E2E69E9CD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Feb 2023 22:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjBUV7j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Feb 2023 16:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBUV7i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Feb 2023 16:59:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F4E298D9
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 13:59:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c23so1761933pjo.4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Feb 2023 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8nlKpp35nn9JzalqXxXLH1RLec6Phwv+6bb+CkAiUk=;
        b=GdtNqbO3Xu8NdkzgHYnnfXNT85SaWtyxMEnDDIg4nY5BVZ5CYd+0JypQETc6oVPpFH
         WSW0pZP9v0OgYpC+b4f/6lP323U/3mTUKeAgfIQ5yYnBI2T8/Cc2C56zeAWOqa9Ef0tj
         vfCzTdF+lkX4v01eTRfNAxvyIPFE2uM4VlC0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8nlKpp35nn9JzalqXxXLH1RLec6Phwv+6bb+CkAiUk=;
        b=kai/9ne5MfkFcJWu9nlC5FZsqwseBRqNEkAeWTW7rP+DlXq+9KI0f3KtW6ZCVyCtlW
         vqhoDbOmlRSpJ5kMmxEe++2HysbSmDKgzaj6dc8JjmbvvWT745OzBFk6k8BnSwVO3Emu
         uJq7XC4VhZBAczpE9T02y2kcFJQR7Bqawh3dv1MwoytooUH0/xeIGHQ2MYCu/cdlx7rO
         P4YxmkDFcXn+zB0tsahLd5ApnUDXq7SREwPjiqlDrrRjJAYOgW6jl88oVnAeZMRTohMR
         MJvTaDEr6oC36deMH/FXVrPLsIOJawTdz+2IF6s2tJbG7Ix9kkrV/sYUaI6PZ/nsnkgf
         9/Tg==
X-Gm-Message-State: AO0yUKV+aenLR/qMWjXRnGm6e1al07c42YbP6EdDxnqtQO0dJeV0Acbf
        N9rvL9hp4ma8FJHe0ZXFLFfG7mCMJiaCM69E
X-Google-Smtp-Source: AK7set8xaHBfij1BcBNgP3pSnANTBddwCKQT6aCBEmQSiLb+A1IwDxkH/8AlgsMHgRV7qJLG6U99nQ==
X-Received: by 2002:a17:90a:10d6:b0:237:1d83:3d97 with SMTP id b22-20020a17090a10d600b002371d833d97mr4562075pje.21.1677016774968;
        Tue, 21 Feb 2023 13:59:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f0a9:384c:abd0:d6ba])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090a3cc700b002348bfd3799sm3093038pjd.39.2023.02.21.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 13:59:34 -0800 (PST)
Date:   Tue, 21 Feb 2023 13:59:31 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     ganapathi017@gmail.com, alex000young@gmail.com,
        amitkarwar@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mwifiex: Fix use-after-free bug due to race condition
 between main thread thread and timer thread
Message-ID: <Y/U+w7aMc+BttZwl@google.com>
References: <20230218075956.1563118-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218075956.1563118-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Feb 18, 2023 at 03:59:56PM +0800, Zheng Wang wrote:
> Note that, this bug is found by static analysis, it could be wrong. We
> could discuss that before writing the fix.

Yeah, please don't accept this patch. It deserves an "RFC" in the title
at best. Sure, it's an identified race condition, but the cure here
(deleting all possible recovery from firmware crashes) is worse than the
disease.

There's no real attempt at analyzing the race or providing solutions, so
there's not much to discuss yet.

Brian
