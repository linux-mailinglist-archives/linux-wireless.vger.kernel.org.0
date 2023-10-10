Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01CD7C44E6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjJJWuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Oct 2023 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjJJWuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:23 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828F184
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 15:50:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-58e119bb28eso274594a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Oct 2023 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696978208; x=1697583008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2ph4e3aw3myowCBYVpWGXZK0YS95STvUJ4nSeseoUo=;
        b=gI4e5XqTajQKEPi50KbEZB0HoCzzK9XziB5Cyf6iK1MfUkMOvFoz7eMMAPIsDeVuYB
         whc3Bxpkz+z7sIqHcb1JOsz+bl8lzh7oHBYpIl5EtqWKdZ0SGaCBL8vmDHQrZPviLJc+
         E1VCq6FAD6B7yqKCTDHxrgcOD96qjZVQJqgY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978208; x=1697583008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2ph4e3aw3myowCBYVpWGXZK0YS95STvUJ4nSeseoUo=;
        b=h26xTNstGUxSGIaR+QyPTgaQCZ3an9W5l3wbecBV9jpX6ikBPS9cXDT5heiFjc14nB
         Gh89i5U0Qqoj1cMiFySdpyipCuKxP8ZGfWhpyrdZ2y9r5EHWBz26xdZRCy65G43+tLVU
         hRm4O0IuA+0/0hnXMWWRHrAQ8J5YHXy4KQlMv8JEFDFrqVXudNtjSgr1L6jCA2+8KTQs
         n96iW6GWeXv0KXdG2QXVQxuOC/23woIJWdwAuqHhAIzyRr84QlJIZcjNUmWXuWylD0EW
         PSAQbWFm4hdTMOzDmsrGUDS9827Vq34blgn8jIGoOBNhxXnBk8JXekEP2DUi8iLU2T45
         hPhQ==
X-Gm-Message-State: AOJu0YzFyRujc7cyYY7QteKVziv2ZleCVly/iEnfPcbzt4qzbYRPTLyt
        CsZV9DFRpcjLn2bpvFa3QE4bgA==
X-Google-Smtp-Source: AGHT+IHMjjMmufUYlfMeoiy4n2bRLKopeW77T7iwNUpfO2rnyXe54YxZIWGrE/Lf+yAz7OEr8Uu0pQ==
X-Received: by 2002:a17:90b:4b47:b0:27c:edf7:db4a with SMTP id mi7-20020a17090b4b4700b0027cedf7db4amr4226933pjb.16.1696978208228;
        Tue, 10 Oct 2023 15:50:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bx4-20020a17090af48400b0026b76edd607sm10596603pjb.15.2023.10.10.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:50:07 -0700 (PDT)
Date:   Tue, 10 Oct 2023 15:50:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <202310101549.E09DE6F@keescook>
References: <ZSRXXvWMMkm7qqRW@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRXXvWMMkm7qqRW@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 09, 2023 at 01:41:18PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I realize I didn't actually send my R-b for this thread, so here it is:

Reviewed-by: Kees Cook <keescook@chromium.org>

:)

-- 
Kees Cook
