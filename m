Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4D532CF9
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 17:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiEXPJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 11:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiEXPJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 11:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A9978B0BD
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653404952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEo1NssAVGQZOfwlIMOHsifxPwTmlidTFKTUs0/1OgM=;
        b=DcvIOvL30ydpi6+1pfrnDA5J9xTtf6qFXULhjdAnW/buRVUjZjmC6eQybQx3c2tM0kZPqs
        Ks0nEMrhm/o45+qj03JRimfoJeuwK3ojuYVXjnUHA42jj30EBjXU69SRk3KdvqwWNFVPW/
        8j/aD18j71xWo6qd/jp5pLPNA2KExbY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-ntYFT8j9O82gT17X5MPDxg-1; Tue, 24 May 2022 11:09:09 -0400
X-MC-Unique: ntYFT8j9O82gT17X5MPDxg-1
Received: by mail-ot1-f70.google.com with SMTP id t23-20020a056830225700b0060af8ce01f9so3800961otd.22
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 08:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XEo1NssAVGQZOfwlIMOHsifxPwTmlidTFKTUs0/1OgM=;
        b=CHa7aRadr37YuGbLAbD6/o4JQQYh04at1fp4h3lYx93jjFAGUi4pDO8ePaMEMKICMF
         SD1ZCvI3+PuIw1tjz4gyRWCO47gApyyy+waMsN/JOS2oRgC9qgiCM5br5vxxlafW9zZC
         Y8iROmHXfqURc6TLblA3Vfrcv8LaifTlk72FcUvJyJRNXwsBQ9ZPCtgYGrg6+uCC7K6G
         uO3hsxQohlzmj9j+D08Np7/G9GKTPQj0VfO7mkqHqYXPvOapXBWhQsEbED+ga5SmDPqB
         GINQDmMhyKEdG4lK7b0Cv+LPLu8sH/m4/8AXogku6ILQM171zSsmoN6HxH1WvvteXImj
         eJDQ==
X-Gm-Message-State: AOAM531/Shnqa3T2ezRi8px7ikP75FJWjpAr1pC6YQpLSZALTBAY1JfE
        duz+slPN5wkUY9MSqpETnPmCWt/22vQOY8N4U/7ckGLBikjQ59pkoE8IL/SU5wmPZFQWHpXS7nn
        moo5PTLcDIXpgVuM58IFS4ajIXzc=
X-Received: by 2002:a9d:811:0:b0:60a:b6f2:ab85 with SMTP id 17-20020a9d0811000000b0060ab6f2ab85mr6516332oty.9.1653404948242;
        Tue, 24 May 2022 08:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2Rrz8fDExW7WCjRqyXrFYjg5Q3G0iEtos25IWByh96ynkYINF5ql63GdcjlrT4RcCKJU4fg==
X-Received: by 2002:a9d:811:0:b0:60a:b6f2:ab85 with SMTP id 17-20020a9d0811000000b0060ab6f2ab85mr6516299oty.9.1653404947414;
        Tue, 24 May 2022 08:09:07 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id k17-20020a9d1991000000b0060b0b638583sm3021001otk.13.2022.05.24.08.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 08:09:07 -0700 (PDT)
Subject: Re: [PATCH] ath6kl: Use cc-disable-warning to disable
 -Wdangling-pointer
To:     Nathan Chancellor <nathan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220524145655.869822-1-nathan@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c7a804ed-e00c-8a32-db21-c689312e0073@redhat.com>
Date:   Tue, 24 May 2022 08:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220524145655.869822-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 5/24/22 7:56 AM, Nathan Chancellor wrote:
> Clang does not support this option so the build fails:
>
>    error: unknown warning option '-Wno-dangling-pointer' [-Werror,-Wunknown-warning-option]
>
> Use cc-disable-warning so that the option is only added when it is
> supported.
>
> Fixes: bd1d129daa3e ("wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Tom Rix <trix@redhat.com>

Thanks

Tom

> ---
>   drivers/net/wireless/ath/ath6kl/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath6kl/Makefile b/drivers/net/wireless/ath/ath6kl/Makefile
> index 01cc0d50fee6..a75bfa9fd1cf 100644
> --- a/drivers/net/wireless/ath/ath6kl/Makefile
> +++ b/drivers/net/wireless/ath/ath6kl/Makefile
> @@ -38,7 +38,7 @@ ath6kl_core-y += recovery.o
>   
>   # FIXME: temporarily silence -Wdangling-pointer on non W=1+ builds
>   ifndef KBUILD_EXTRA_WARN
> -CFLAGS_htc_mbox.o += -Wno-dangling-pointer
> +CFLAGS_htc_mbox.o += $(call cc-disable-warning, dangling-pointer)
>   endif
>   
>   ath6kl_core-$(CONFIG_NL80211_TESTMODE) += testmode.o
>
> base-commit: 677fb7525331375ba2f90f4bc94a80b9b6e697a3

