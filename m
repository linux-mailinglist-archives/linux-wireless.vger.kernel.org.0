Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA077BEAF7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378489AbjJITye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377185AbjJITyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 15:54:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205694
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 12:54:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so3139417a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Oct 2023 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881272; x=1697486072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r26b0Slyc6tlKUbCmKfqJbWY2dJksE7xOezOXiapAXU=;
        b=hCQThWCp5M14QcE6neDZ9LRlSfyd1Eg610MfNgqJ39uEHe1b3WhRbW5BrK4XeO+NP6
         ILvjHrYJhDienqW2jwEVLn+ZxCLon6HzUyhcau5g4P/H81QnlwbI8e3h5h5DBjZAK8aY
         brKmVmFH7yySY5++RLTGHYVfCqKtWv9hG1HgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881272; x=1697486072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r26b0Slyc6tlKUbCmKfqJbWY2dJksE7xOezOXiapAXU=;
        b=oiJ+q6Urv3JO5htp+l3WPQsne7i9AwgTqqnnISvrOCiTAwqg05NKtdDQZw0miRKS0d
         ePxVU3sIFMU8WUXOiS55hhT6w+kJof32nUjaV+kFfWDJK3371DrSJen+IU1JZx0RXPz+
         /ztrbslal8eFNkeZESCnPruuLGcZS7LZYI8J/Ihuj6z6+k70p+Bbur9T5P6LQ0idITzF
         jyAwho+gDBXOIFpjCldUrFtvIpkLtnyK2PljjryV29bdpP1IU8y4ZvYoTKXFB7kp7BV1
         igfodQSc72SoMuvXLMkTO0I+8wwecdFK9isVj3u/PJIGYXCPQqLKLc8Q9kcwLakXwau9
         UElA==
X-Gm-Message-State: AOJu0YysE1kGmsBAD4K7fYjQObvoKEd0hSvUbsl11B7OB2EMSEtRUL/g
        7M/iuldAlRyIQCfwmaX5Aqlpgg==
X-Google-Smtp-Source: AGHT+IESAB+NJWWS83JNTCQShMVApHbrs5iVd0p2IdvEZY4yPRWW6v0obm+AH6EHKoWT37U2eoIGFw==
X-Received: by 2002:a05:6a20:9189:b0:153:b16e:8db1 with SMTP id v9-20020a056a20918900b00153b16e8db1mr16309776pzd.10.1696881272053;
        Mon, 09 Oct 2023 12:54:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001c755810f89sm10037555plb.181.2023.10.09.12.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:54:31 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:54:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Message-ID: <202310091253.665A9C9@keescook>
References: <ZSRXXvWMMkm7qqRW@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRXXvWMMkm7qqRW@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
> ---
>  drivers/net/wireless/intersil/hostap/hostap_download.c | 3 +--
>  drivers/net/wireless/intersil/hostap/hostap_wlan.h     | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
> index 3672291ced5c..5e5bada28b5b 100644
> --- a/drivers/net/wireless/intersil/hostap/hostap_download.c
> +++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
> @@ -732,8 +732,7 @@ static int prism2_download(local_info_t *local,
>  		goto out;
>  	}
>  
> -	dl = kzalloc(sizeof(*dl) + param->num_areas *
> -		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
> +	dl = kzalloc(struct_size(dl, data, param->num_areas), GFP_KERNEL);
>  	if (dl == NULL) {
>  		ret = -ENOMEM;
>  		goto out;
> diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> index c25cd21d18bd..f71c0545c0be 100644
> --- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> +++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
> @@ -617,7 +617,7 @@ struct prism2_download_data {
>  		u32 addr; /* wlan card address */
>  		u32 len;
>  		u8 *data; /* allocated data */
> -	} data[];
> +	} data[] __counted_by(num_areas);
>  };

Should this be considered a v2 of:
https://lore.kernel.org/linux-hardening/94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com/

?

Yours is more complete since it includes the struct_size() change...

-- 
Kees Cook
