Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3A7ED604
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Nov 2023 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbjKOV1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Nov 2023 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjKOV06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Nov 2023 16:26:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA21A4
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 13:26:51 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc34c3420bso1272105ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Nov 2023 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700083611; x=1700688411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPVyRrN1uRZs7Wz4idyzDBpkXVrVgQKZvwp5LF85yFM=;
        b=VKsHDqAZgBJA/hD42MObdrmrNLDkPQWr+5eDeZeDc7A0c7CIgEOSH5xS+orPGkaH05
         GPEbYOcftgTW/Bebwva9UDF0hc2oP6pZmFD8QzHqkPVmBzCxImJSlygYF/gJk+zJkByo
         9F49L9vpQhd4M3OpsEdS802A3AoC2NKaT7S+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700083611; x=1700688411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPVyRrN1uRZs7Wz4idyzDBpkXVrVgQKZvwp5LF85yFM=;
        b=vzaFoCi6nkPosQdUAYEOop8jmBoset4kRnYdyZUzJZA0OWzLlBMrv9x+QPPHVJBuup
         HnkNRyeQhOYGM3q1WDfBZDigjhRaKDNy3zok1hVTipMCj6T1qu2fX6YFOco1wtYyImog
         VRPwB4LMDrj/RZ5NHAkF9CSZTsO8FEmosAqpn3lHzvGL434USGmmikZ7PGd4cd9kTxHo
         aabWjCwI+5KgTPYdU21FkhuTQ63I50KEkQhEFWmPelKz1JUP+YGC680IIjc1BIgj6StE
         4VODfv3M8w+uZ4wrRAaKUaLbPf48ERlIBlaPHfLVYu59e4EQAH3bM5kXiYIZiIYCVoHF
         rh2g==
X-Gm-Message-State: AOJu0YzuZBJhEBd257UyqRArI6xMEJjE7PgCm1ewYxZW1daLUy3xnfb3
        lqJCZXGAgZdQgN41oQGjvalr3w==
X-Google-Smtp-Source: AGHT+IFRKVgCfEa6Z+5pQ2Y0fxgccYlOkaOEmT5jf2DSAM02NTazA4S/MQNc/T6ApIjdrff/U85aKA==
X-Received: by 2002:a17:902:6b03:b0:1cc:40a4:9179 with SMTP id o3-20020a1709026b0300b001cc40a49179mr5793617plk.34.1700083610553;
        Wed, 15 Nov 2023 13:26:50 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:ff48:d9fc:165e:3caa])
        by smtp.gmail.com with UTF8SMTPSA id a13-20020a170902b58d00b001c61acd5bd2sm7808729pls.112.2023.11.15.13.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 13:26:50 -0800 (PST)
Date:   Wed, 15 Nov 2023 13:26:48 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     kvalo@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, lukas@wunner.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mwifiex: remove some useless code
Message-ID: <ZVU3mGzR_759WYAW@google.com>
References: <20231115092328.1048103-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115092328.1048103-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 15, 2023 at 05:23:29PM +0800, Su Hui wrote:
> Clang static analyzer complains that value stored to 'priv' is never read.
> 'priv' is useless, so remove it to save space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c | 8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Brian Norris <briannorris@chromium.org>
