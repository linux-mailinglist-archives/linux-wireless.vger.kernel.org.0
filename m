Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6F742E30
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jun 2023 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjF2UNB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jun 2023 16:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2UNA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jun 2023 16:13:00 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633B2D5B
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 13:12:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51452556acdso857688a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jun 2023 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688069578; x=1690661578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpFu2g9owQYp6gj4kYe+hqK40cCjGL392Rh91m0VFkU=;
        b=ItN+OQOq+f3Rdj1z0HbngihoxHd6uXVVq+mNpUXU+alPzMreoW+OgBsZ7iPri5QN5+
         O337Hlhx8BpRJfyFMRZPav8XQ/Bzu0E3cLsmoefG6cZoxote2tugoDkKrEdOfAF2LBWI
         QLlAIKyAGjUN+jotCm2vyBcbML2ruwwSWfmN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688069578; x=1690661578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpFu2g9owQYp6gj4kYe+hqK40cCjGL392Rh91m0VFkU=;
        b=IA7FNmLi4j2dLJ9mbx7e0e6cx0tpnbnIdqOwxTzEcqA9FRA4FMqRh265EpH+ezzVsH
         /ctsF/9/IkocOuXj80x1nG2Pnw2VK0WScND0OBT7+nsHuwJJ/0FymUuZRkONqJM1QCu2
         aPvnblH2h8KgzDiTV+asOg/mlGQP9TN0d9AYet8IP27Ci4P3J7rF5++3rbJ9mYZ5JSsS
         JGZDslNrtbrnxE3bomZHY7IrrcJHSeDgWYr88WkEEqYcvLY9M+jHOx+Hqzibb0ICypsu
         FuOxaYseUswlECncGwTZ3N0hzmxrNbIzoZCnFo8guOLs23ZJM32mP+5VqKEowWQL523A
         RAXw==
X-Gm-Message-State: AC+VfDyWV0OaYQ0KhfrOPJ6KLsKpetxQdrcp5DdC3jOOAUBTQyAep6dM
        C1DT8X0GR6dJTrq5UgE4tTCjQQ==
X-Google-Smtp-Source: ACHHUZ5yH6jAbH48TRZe/55yopoQYeKWl4rmD0NdAI2gFBlvtXKYuZWrBIoRP0SrxecUoKMzP+SD6w==
X-Received: by 2002:a05:6a20:3b14:b0:123:8852:1a12 with SMTP id c20-20020a056a203b1400b0012388521a12mr662760pzh.23.1688069578543;
        Thu, 29 Jun 2023 13:12:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3c2b:cbff:22ae:80d6])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0065da94fe917sm8685360pfn.36.2023.06.29.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:12:58 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:12:56 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] [v4] wifi: mwifiex: drop BUG_ON() from TX error
 handling
Message-ID: <ZJ3lyIQy7GPbA9YL@google.com>
References: <20230629085115.180499-1-dmantipov@yandex.ru>
 <20230629085115.180499-3-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629085115.180499-3-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 29, 2023 at 11:51:02AM +0300, Dmitry Antipov wrote:
> Remove 'BUG_ON()' from 'mwifiex_process_sta_txpd()' and
> 'mwifiex_process_uap_txpd()'. In case of insufficient
> headrom, issue warning and return NULL, which should be
> gracefully handled in 'mwifiex_process_tx()'. Also mark
> error handling branches with 'unlikely()' and adjust
> format specifiers to match actual 'unsigned int' type.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v4: initial version to match series
> ---
>  drivers/net/wireless/marvell/mwifiex/sta_tx.c   | 13 +++++++++----
>  drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 13 +++++++++----
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> index 13c0e67ededf..d43f6ec1ad37 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
> @@ -39,14 +39,19 @@ void *mwifiex_process_sta_txpd(struct mwifiex_private *priv,
>  	u16 pkt_type, pkt_offset;
>  	int hroom = adapter->intf_hdr_len;
>  
> -	if (!skb->len) {
> +	if (unlikely(!skb->len)) {
>  		mwifiex_dbg(adapter, ERROR,
> -			    "Tx: bad packet length: %d\n", skb->len);
> +			    "Tx: bad packet length: %u\n", skb->len);
>  		tx_info->status_code = -1;
>  		return skb->data;
>  	}
> -
> -	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
> +	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
> +		mwifiex_dbg(adapter, ERROR,
> +			    "Tx: insufficient skb headroom: %u\n",
> +			    skb_headroom(skb));
> +		tx_info->status_code = -1;
> +		return NULL;

I'm not sure why this return (NULL) should be different than the one for
skb->len==0 (skb->data). mwifiex_process_tx() has...weird handling for
both.

For NULL, we fall into a default (ret==-1) case where the error message
is wrong ("mwifiex_write_data_async failed: ...").

For non-NULL skb->data, we still try to queue or transmit the
skb...which seems wrong.

I think they should both be returning NULL, and mwifiex_process_tx()
should improve its error handling to more explicitly handle that case,
instead of printing the wrong error message.

(Now, I expect neither failure cases are actually exercised in practice,
which makes most of this moot...)

I'm also not sure why this is part of the same series as the others.

Brian

> +	}
>  
>  	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
>  
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> index e495f7eaea03..b27266742795 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -452,14 +452,19 @@ void *mwifiex_process_uap_txpd(struct mwifiex_private *priv,
>  	u16 pkt_type, pkt_offset;
>  	int hroom = adapter->intf_hdr_len;
>  
> -	if (!skb->len) {
> +	if (unlikely(!skb->len)) {
>  		mwifiex_dbg(adapter, ERROR,
> -			    "Tx: bad packet length: %d\n", skb->len);
> +			    "Tx: bad packet length: %u\n", skb->len);
>  		tx_info->status_code = -1;
>  		return skb->data;
>  	}
> -
> -	BUG_ON(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN);
> +	if (unlikely(skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN)) {
> +		mwifiex_dbg(adapter, ERROR,
> +			    "Tx: insufficient skb headroom: %u\n",
> +			    skb_headroom(skb));
> +		tx_info->status_code = -1;
> +		return NULL;
> +	}
>  
>  	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
>  
> -- 
> 2.41.0
> 
