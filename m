Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0A3AD105
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 19:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbhFRRRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhFRRRG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 13:17:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA278C061574
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 10:14:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g4so6083588pjk.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jun 2021 10:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IG1N/xYEJPDHXZM58vax/RZqEdUoBLDIXoPzlvwPpq4=;
        b=XVMSUkOBoyHfSQlN0FVLe7Gm3IY8nt2yFfBQSg2POl3XMDU024mnmVlwKkuLplEOWH
         D39TIEwx7B8TWSyPIv8oYeZ/EwOMyvT7gGOURGkwwhc/YOF6jTn75AD62AT7ieK+e3vb
         5XzrPhbGTElZRDMwQvhuJjUIzZkp0Wz9T2qV7Y/YLTnOgIeMkUswJqCU8RHOuk84ynn5
         Q8xqWtjQ6nuxPU49weqONjnY2GxhDY01tcmBEwS3OIG54w5DYf0BS5W1/Di33BGoHhGf
         aP8F0CMgfZo6/vjNCR4HgyTUZ+kxUW+vhySvE2uprg1GN9Bgh3FLPYjCOO5lmfReLnkU
         PwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IG1N/xYEJPDHXZM58vax/RZqEdUoBLDIXoPzlvwPpq4=;
        b=FppzFb0/oc1Jhu7u4O6Pqx1caJRRh32SbfIqER6f2AUmy5XXqhP+vBvae25z8UUEvc
         LbEIbXPXwOjpsv7WiaAs4fkXogW4582E4TKs6TXk5fOSiAq6raKNRqzpiNQGrAuSK5jd
         TVITaJ7RtTCaGKpWeqTMOownh3AX9mEFAdAAe0uhF29DUL1Kt4usGvAFLnT0kBhDlr2R
         aDfmfVySdG1s4NszwPFNmOW5HyrMh6BslmwDQ3RVqjCgGKF7NrJ72QWjMK9FHWD8QnNQ
         LKovTvW0L80SmMzVhTB3HDgnH5uaekjn14+pEHUF7H+0DYRbF4/9rVXo2Ssy7U4NJPls
         BCxg==
X-Gm-Message-State: AOAM531lEgBRPHl2V+vdHPkZlZVux0EeLHPFHfKVQhDXhBEnspt7YAKc
        QiYcZDwau3BNEZ5aRpITWquf2/7jfqU=
X-Google-Smtp-Source: ABdhPJxK1dbjiWmmYHgUD0/1MBsLFlYSEOYkZvUNGByoBy/Xm1mLbqhbyaAsA5HK+vlqviKMcAvqNw==
X-Received: by 2002:a17:902:c403:b029:106:7793:3fcc with SMTP id k3-20020a170902c403b029010677933fccmr5616695plk.81.1624036494787;
        Fri, 18 Jun 2021 10:14:54 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id u24sm9120526pfm.200.2021.06.18.10.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 10:14:54 -0700 (PDT)
Subject: Re: [PATCH 02/31] mac80211: do not add twice the HE 6GHz cap IE
To:     Luca Coelho <luca@coelho.fi>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <20210618104156.747775-1-luca@coelho.fi>
 <iwlwifi.20210618133832.5b2063dea3b3.I56248f2ce2e22a5c0cf797378726f6904b5de5e2@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <db8585de-f1a2-b40c-0e4d-30dc5ad1d6ae@gmail.com>
Date:   Fri, 18 Jun 2021 10:14:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <iwlwifi.20210618133832.5b2063dea3b3.I56248f2ce2e22a5c0cf797378726f6904b5de5e2@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 6/18/2021 3:41 AM, Luca Coelho wrote:
> From: Shaul Triebitz <shaul.triebitz@intel.com>
> 
> The HE 6GHz capability IE is already added before:
> ieee80211_add_he_ie -> ieee80211_ie_build_he_6ghz_cap
> 
> Signed-off-by: Shaul Triebitz <shaul.triebitz@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  net/mac80211/mlme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 2480bd0577bb..310cfd02fda4 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -8,7 +8,7 @@
>   * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>   * Copyright 2013-2014  Intel Mobile Communications GmbH
>   * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2020 Intel Corporation
> + * Copyright (C) 2018 - 2021 Intel Corporation

This change only bumps the copyright year...
-- 
Florian
