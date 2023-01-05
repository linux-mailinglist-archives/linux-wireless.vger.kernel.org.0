Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075C665E515
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jan 2023 06:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjAEF1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Jan 2023 00:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjAEF0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Jan 2023 00:26:51 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC86DF41
        for <linux-wireless@vger.kernel.org>; Wed,  4 Jan 2023 21:26:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 187-20020a4a09c4000000b004d8f3cb09f5so5172689ooa.6
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jan 2023 21:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OejcpZVMfMg3HPzlGve79DiPK6ngwBTotFLTcHuW0S0=;
        b=J6UJsKf/o83rMEvTny2BngrmRZsqGt+0e84OD41ne1VVCEZHscE+TS70G/Mlm5uvoc
         9i9uE2bQWTWmP1jE3MMcEGYgbfp54Z1XQvi1BcCDBhA77hvZYTubLqQavXuI2ETnP9Gg
         LhW50GGL2fAHsBr/50pXJ2zw4lDWVge8aILzWLY/cJ/FSo1weiSTAvUtwgAyDmpBwDlX
         nSqKmObiT1GXe0uAEYKK9bccQAuwM//Mom226qhJ/6++HYXiYU5ToL8l1qjsWWIP84Da
         LmlsNlOZ5BVL67/cR4Ibd986+k8QuHJTQhBocivE4jTaWCGAUBwmjS4/wlmPwzl0mEki
         DC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OejcpZVMfMg3HPzlGve79DiPK6ngwBTotFLTcHuW0S0=;
        b=ZeT39gcnJs+JaFJMLtx2f3lOx2keZHUkhC62x5KRbD56uwBf8VHsITbO6FR1jJv6jm
         HcRFd2LWSJxYvqkX/dBQ8abqiPGKULYMWFG23JhOUBB9O0xPPsG6qSQnBXOzrAaWSrkO
         BQrVIDeM8n404nDZJxLyvVLH+tOECLTJ48yABWWRRMuto9f/PpePTVR9z0SovyMwddtF
         0v4vfISeNsHjAEslHkpntrbLqxS4Giifuh8Ustl/qyqHO5WQXl82CDWggUQqqUUuvWU1
         Cs6BZ0bNMeWRUCnqooan810+DtTjIb/lJTzkIqbAPK6IkX48zZC3AWrAgvbfy292lpjA
         4aPA==
X-Gm-Message-State: AFqh2koWXjzp0icgAJMFHmkJ18n0R9+rDlzYyCnSCwCHzrgXqrw0b585
        fs6bzR+ois/nlsS9HMrihCjtwRwCsKI=
X-Google-Smtp-Source: AMrXdXttu0b/leqvQ8POfETF0m7gdR0UtPXKHCzV8TzDzqgpBV5fm3PJMcTXvidr7VJaAL6mzGGkOQ==
X-Received: by 2002:a4a:df0d:0:b0:4a3:e7ac:d31b with SMTP id i13-20020a4adf0d000000b004a3e7acd31bmr26779114oou.5.1672896410090;
        Wed, 04 Jan 2023 21:26:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a4ab64d000000b004ce5d00de73sm12342587ooo.46.2023.01.04.21.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:26:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 4 Jan 2023 21:26:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mac80211: change initialize for sk_buff in
 ieee80211_tx_dequeue()
Message-ID: <20230105052647.GA2477583@roeck-us.net>
References: <20221212083607.21536-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212083607.21536-1-quic_wgong@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 12, 2022 at 03:36:07AM -0500, Wen Gong wrote:
> The sk_buff is only set to NULL when initialize, sometimes it will goto
> label "begin" after ieee80211_free_txskb(), then it points to a sk_buff
> which is already freed. If it run into the "goto out" after arrived to
> label "begin", then it will return a sk_buff which is freed, it is a
> risk for use-after-free.
> 
> Fixes: ded4698b58cb ("mac80211: run late dequeue late tx handlers without holding fq->lock")
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

I don't see any progress on this patch. Is there a problem with it ?
Did it get lost ?

Thanks,
Guenter

> ---
>  net/mac80211/tx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 922932ca02191a390f7f52fb6e21c44b50e14025
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 2171cd1ca807..0b23cc9ab9c7 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3776,7 +3776,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  	struct ieee80211_local *local = hw_to_local(hw);
>  	struct txq_info *txqi = container_of(txq, struct txq_info, txq);
>  	struct ieee80211_hdr *hdr;
> -	struct sk_buff *skb = NULL;
> +	struct sk_buff *skb;
>  	struct fq *fq = &local->fq;
>  	struct fq_tin *tin = &txqi->tin;
>  	struct ieee80211_tx_info *info;
> @@ -3790,6 +3790,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>  		return NULL;
>  
>  begin:
> +	skb = NULL;
> +
>  	spin_lock_bh(&fq->lock);
>  
>  	if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||
