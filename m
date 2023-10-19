Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C643F7CEF04
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 07:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJSFb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 01:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjJSFb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 01:31:27 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB4AB
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 22:31:25 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2df2fb611so1502853b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 22:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697693485; x=1698298285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQUGhOb1d52LjL06uQonhVptEtMNbpeNfk7oX9QEu7s=;
        b=OkvA6dljzrAPjqCzrj85TUMf6HLxvnu43JuOsNh/xfI3Sy5IS1wnuPtRw2QAQeGs8a
         KGGwmc/PxQNNXeUsMuy/aMgj0kn4tBzZA3449LwCiSIrmphUMjWmxM+dD4qHDhOA00lQ
         t6qrGMJUCHM63+65eC3SraPmZTFz5S0MgYyWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693485; x=1698298285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQUGhOb1d52LjL06uQonhVptEtMNbpeNfk7oX9QEu7s=;
        b=KS/+9kbs4swjaiFYbxo+AVPFEuv0VfGutg4LC4X7K7wPxCy6bpu6OCHClmcBMe1fYQ
         0Y+4e4FU5R24+jHr4QAuFr9JPp/Qek9y//eM+A8fEhUZNAC2zKco5S9sGhh4305IaANa
         d/K/mJ9QWE6iJLHqv4p3EH0vk0vqj6k88ubGN14BRTTPFnhxfMfsYWb9C6bdWvcplytV
         KXIZXJSqOcjqGtrOlSzPFHNdLeFEqbNH/s5q+9tuh794oo5A6prL3U2oTy1+qW4gB2Xl
         aewrSLpHzyyf/sJR/YHVz1fzyWYxRpHfm9ZUpvBSZ2PYjUq53JrSXlUigC6yL2jAQ6al
         PPww==
X-Gm-Message-State: AOJu0YzUgi2J2PPLmxB+tGMQC1xTDBLLlA417TZ03Na4rD561cBVMzrb
        4lzd1Z3796kUMcg3cWZ6owdAIg==
X-Google-Smtp-Source: AGHT+IGMXYikMZUI7rRo5t7TX4SAHa5RPGLKESsSBBN1BIiUxqbQJpZ2JpPoE3azqi92heqcaXQwfw==
X-Received: by 2002:a05:6808:2011:b0:3af:63ad:a610 with SMTP id q17-20020a056808201100b003af63ada610mr1579138oiw.14.1697693484978;
        Wed, 18 Oct 2023 22:31:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cb14-20020a056a02070e00b005b44ac59b7bsm2280416pgb.70.2023.10.18.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:31:24 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:31:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: main: replace deprecated strncpy with
 strscpy
Message-ID: <202310182231.052A44F@keescook>
References: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-strncpy-drivers-net-wireless-ti-wlcore-main-c-v1-1-1b1055f482a1@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 18, 2023 at 09:50:01PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect fw_version strings to be NUL-terminated based on other similar
> assignments:
> 
> wireless/broadcom/brcm80211/brcmsmac/main.c
> 7867:           snprintf(wlc->wiphy->fw_version,
> 7868:                    sizeof(wlc->wiphy->fw_version), "%u.%u", rev, patch);
> 
> wireless/broadcom/b43legacy/main.c
> 1765:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/broadcom/b43/main.c
> 2730:   snprintf(wiphy->fw_version, sizeof(wiphy->fw_version), "%u.%u",
> 
> wireless/intel/iwlwifi/dvm/main.c
> 1465:   snprintf(priv->hw->wiphy->fw_version,
> 1466:            sizeof(priv->hw->wiphy->fw_version),
> 
> wireless/intel/ipw2x00/ipw2100.c
> 5905:   snprintf(info->fw_version, sizeof(info->fw_version), "%s:%d:%s",
> 
> Based on this, NUL-padding is not required.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

More clear replacements.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
