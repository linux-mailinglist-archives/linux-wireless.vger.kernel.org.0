Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594627D05BF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Oct 2023 02:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbjJTAQ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 20:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbjJTAQ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 20:16:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD311D
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 17:16:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9bca1d96cso1988205ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697761015; x=1698365815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXqB68dRwnEMiiJyZnk0HaHWGXtH4u6C3mPwBphJGJI=;
        b=G5wVzMflm6pjtAG2F4wxnwxKzMoJF4YRfJroGHEyKZFSVg2NGclIVpugZdvSD4wVMN
         +y0ueksEQN6T9Ob4H3ZrgrtvO33Z35WK8pGFguYozQY5cT3PxHfdWoZvUhP45MWnnVJ0
         TTw02fWltsIdYmSIBZ3lGPNckb4qBQFroPmtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761015; x=1698365815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXqB68dRwnEMiiJyZnk0HaHWGXtH4u6C3mPwBphJGJI=;
        b=H1eMSPZJIFy15yvWU4RB/nGKbOFJla7F8KBSc53IPVh+IBEwzhrFeus/o0yWw1rjrt
         GRWEG2PpzmFGrMSYDpYlXlF/mEaMGwPiTLkdVMAZ8sNgg641t8W5RuqIjsqen7nhOabc
         hBeV9HwbR5+ESU1Xh2w3PHLcTcTxFzpOIezaQohaXBTgyEabHiKr6PfZEiEfzu3d9S1K
         1iCp9az1mHVDYzOJCtfj+zvJ13Hpw/POEwRrIWY2Stp1polQZi5r5OgVhM5QvRVv4Y/a
         fdzUHJ69gjpFAkHYhm/im++ZYZpFNc+B6j+4+iP5+86Ii0oabIDVT6ZFRR+H45AuV7Fr
         53Qg==
X-Gm-Message-State: AOJu0Yy45X03Bt7CzwZjOjwdxEoybski5fxUSeQ6WjH3cs4O/7wXQ6Y8
        WbbR41A8NkUeT07NJuzoAUzoXQ==
X-Google-Smtp-Source: AGHT+IFZ1Tr8OeFg/qk6qLnEbh1PqH3aRaYMRLi5/1KpjSSKoPCXfZM1fdYuLAT3Ykx57tGI6k5JUw==
X-Received: by 2002:a17:903:60d:b0:1c9:e6a0:edb6 with SMTP id kg13-20020a170903060d00b001c9e6a0edb6mr398026plb.2.1697761014744;
        Thu, 19 Oct 2023 17:16:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090300d200b001bd62419744sm290200plc.147.2023.10.19.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:16:54 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:16:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310191716.242A205D@keescook>
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 19, 2023 at 05:44:59PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Moreover, since this seems to cross the file boundary let's NUL-pad to
> ensure no behavior change.
> 
> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
> it.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the respin!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
