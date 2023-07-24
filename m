Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2475FC66
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjGXQoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 12:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGXQoM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 12:44:12 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862C5E4F
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 09:44:11 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b05d63080cso3587050fac.2
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690217050; x=1690821850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+TjTacKNd1NhQdt7jObI42EA4Jwu39WR3/FkE7+fC2U=;
        b=ITzcX4CLO4HAn11aRskYcr4wozSAheLPuLywKZ94ivYk3nVdh0PjwhZaFUjcV02UIU
         n4EE/iPA/JaPS+/MaHYNIgGA/LbBvl3G1ESU4QEuJRNHrJNViAVsJfH3WLGvbWVJdzOs
         frCeAWJDi7Y4y9AwBwh+M+UwLl80a+cv3b9HFa//Zh/+sQAZ8Z3r4jf9TDpUxw2nMrQ0
         CfBAcvXxlhfDh/VW8p9zgh+p31zkl6b8fcu3ga990zgegPA9o5YWIzcjrbbSPMeigjna
         bPSyUWLV21T103L7KIN19PePaGBJ+LXVhL2gRlamDgI3ypB25QfZ9gszBsL1SN2gP4qQ
         JWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217050; x=1690821850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TjTacKNd1NhQdt7jObI42EA4Jwu39WR3/FkE7+fC2U=;
        b=VzsEjOY4BHi47CjhC9mP7L39vU8FGwuMmCNLpLSe+qLN5fAIfSYJQZWiPZmAMuBiz0
         EX27qKvoWh5JNuG3hY9PH9RE9n3zpSUriCUucMUqJ1DnkhKsMHOfUnQUSxdCP5oGveJD
         eoweXlfZ/9fNVnhfwizVYbK2yYo4iw014IvISv3El4ZvS612bMJQl/0uEbtrTo3xqpUr
         Qu/0Q2kfuN8Ks9MOgXWDRN4xY9v46nzBVDTvDIObyBGQ5+mzosz9haAKd7+3Qe3LUF3g
         lhblmHQOwMZefeaa6HGxvOu+QQjJpfPaDAk6oHBwzUxk0fke07Ijdzsa4S+7x9JlTNSz
         praw==
X-Gm-Message-State: ABy/qLbrN8dHryPM6VZdZuVaYpjV0xmTFifEq0QRstC3f02iUCuPWOxQ
        Ejxs0YGZieZyly6weO3SSPQ=
X-Google-Smtp-Source: APBJJlGN5LPpxzJII0zu2IA+KlBc2JRvgaksu98j5GY8dr3ctLdLY/TLnBJbcaU0lhmtu9J4TdtIeg==
X-Received: by 2002:a05:6870:96a2:b0:1bb:7f9f:2fc5 with SMTP id o34-20020a05687096a200b001bb7f9f2fc5mr2145135oaq.17.1690217050643;
        Mon, 24 Jul 2023 09:44:10 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870180600b001b02a3426ddsm4516860oaf.14.2023.07.24.09.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:44:10 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <14cfb9d7-089d-607a-9062-eb9e268ffd67@lwfinger.net>
Date:   Mon, 24 Jul 2023 11:44:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 8/9] MAINTAINERS: wifi: mark b43 as orphan
To:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <20230724104547.3061709-1-kvalo@kernel.org>
 <20230724104547.3061709-9-kvalo@kernel.org>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230724104547.3061709-9-kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/24/23 05:45, Kalle Valo wrote:
> There's no maintainer for b43 so mark it as orphan.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e275c077608..a6538fd53887 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3391,7 +3391,7 @@ F:	drivers/media/radio/radio-aztech*
>   B43 WIRELESS DRIVER
>   L:	linux-wireless@vger.kernel.org
>   L:	b43-dev@lists.infradead.org
> -S:	Odd Fixes
> +S:	Orphan
>   W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
>   F:	drivers/net/wireless/broadcom/b43/
>   
Kalle,

Michael Buesch and I have been unofficial maintainers of this driver for years, 
but your change makes sense.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

