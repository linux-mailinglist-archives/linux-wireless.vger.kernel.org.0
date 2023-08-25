Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4533378902C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 23:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHYVKO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjHYVKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 17:10:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC726BF
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0d5b16aacso9023305ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692997795; x=1693602595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioTl4pnPl3Z+sUu/zLbbgMcEXvo9RP4TdutXMy62DoY=;
        b=Bl4a/2bwAgFJ9jQHPgOwtVW76ypJYiv7OBVpItzho33dm0jU6G+PVUJECyF0RmX92G
         ScLc3BXsH7kwklH0VgszuV/glqwgvDbfeqf24mp9bYUDJz6Hi6/s90tpQeDosn0PEEZ5
         wjhg03y2Fo45JobsG831uuKn2iOC7aIQDV+DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692997795; x=1693602595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioTl4pnPl3Z+sUu/zLbbgMcEXvo9RP4TdutXMy62DoY=;
        b=I8cwxGiU5TkvO5jweO6DrRTAONaRKBG86jtzkN6KEo8dW07ooK63+zDNydg3f9eNdS
         jPATmI8kii8uEzTnBQGLD1OjZ2nBucSq2C+HvzD8LNaX6oN3h/cKFlF6wDqmIybopctn
         pXrp3OULjnWk+kICeG7YXi0+94oWDA3By+7kJdKgZwHEAKwjFHOuN5GhMcoMJd+N1W9m
         VPhJc0jU9hCNYhU1X/SKfK+8GGBCgnDiuf7CjkAD0Jcdc6Mfpwfy2/d+tveuDALwX9FR
         vAWmPH9P71T8jaqW9Z2buBNcsNdtlBy8ZlS9vHiTIds3RyLQIuP3dybva6A8R9s/+PRx
         +tRg==
X-Gm-Message-State: AOJu0YzOP5JlnuLxFCIoIVKD99AMKKaEUT2hQad0kz4r55bsUmsiOpqL
        ecDzP+iQXxtdTOu7O7jG1/ILhc9fqoWQiFsbu+Q=
X-Google-Smtp-Source: AGHT+IFMI18U8oAYoerCCz1ml/4BSSkWxer2lCXNRlY65b/XvLu/6VLXjYRjNvHGFbl6mUI06+gjEQ==
X-Received: by 2002:a17:902:d342:b0:1bf:650b:14fb with SMTP id l2-20020a170902d34200b001bf650b14fbmr14746237plk.42.1692997795136;
        Fri, 25 Aug 2023 14:09:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u15-20020a17090341cf00b001bdc9daadc9sm2221180ple.89.2023.08.25.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:09:54 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:09:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 2/3] wifi: mwifiex: Replace one-element array with
 flexible-array member in struct mwifiex_ie_types_rxba_sync
Message-ID: <202308251409.A52310CB@keescook>
References: <cover.1692931954.git.gustavoars@kernel.org>
 <79c801c69c8beece2f80502c60166036d3c047cc.1692931954.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c801c69c8beece2f80502c60166036d3c047cc.1692931954.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 24, 2023 at 09:07:43PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct mwifiex_ie_types_rxba_sync with
> flexible-array member, and refactor the rest of the code, accordingly.
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
