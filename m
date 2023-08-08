Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47A774CA4
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 23:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjHHVNZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjHHVNO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 17:13:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07331A5E3
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 13:11:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc87ded50so40202555ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691525489; x=1692130289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUKpE+oNE0/h0QGs7zyymgJyrDlWJCUBg0EB3+1xZK0=;
        b=Q6iqfmiOrpTlN0MVMyg/J93jDJK62XjmqC1jPntTS3deq+9DqQOJK5OfwbRI9m++ld
         sS1kkZJQb0KZMvsfY8ytGzqDPd2xMeo6jYkIfoa2AsWUK1vafRQG83USTHTgtTkCk9j+
         o3+sxX4S6R2+w/yWmkZUPHKuM4d0Z9faggDJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525489; x=1692130289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUKpE+oNE0/h0QGs7zyymgJyrDlWJCUBg0EB3+1xZK0=;
        b=NWYmzzJrNjUk3HT8kssDWesWwBkHkWM1D3w8icEK7AQ9gaa4FSm5S+Af0r+hBLGkCa
         hHgd6NO+rdKPMdUhv1pgBLZXIy+1lSVGuwWMX+Mxx1QYQws0UPtOPnitOft7WzUq6QWZ
         i7lyM9U+zQ7QyZuvzhE4/No/H9AvUJuCAmRMgYgM7TUbGcxQv/HRSbM/SKgQQIidZdJP
         9f0Pf5eOcuX2UOK9I0DZ9EQQUNexsvYOfJy9tp/Zdy/F34M6sFfFkFL5L6zVAbTcM+So
         vAl6y6yRwpdjCPfQ3map1xXQ1VYg3XYpqmQn2zK3BR24yFcnfFa3Bn6Of826svXEOmoM
         ATkw==
X-Gm-Message-State: AOJu0Yyb27+pnNdDLZaMmDSl1JevUD6JFi1aYxxEho8DQoqTbn4Isceb
        DDoE9V9rSrHDQr2VUsElVhvGkQ==
X-Google-Smtp-Source: AGHT+IFze8kIjj2VOwIZt1iaTBcw0BoCZzkRwjmFv+hEQfOOvj//qiCIl17bad80r4aT2/Lx5j/o9A==
X-Received: by 2002:a17:902:f7cd:b0:1bc:2c58:ad97 with SMTP id h13-20020a170902f7cd00b001bc2c58ad97mr685047plw.22.1691525489554;
        Tue, 08 Aug 2023 13:11:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:800e:831a:c5f6:2dd0])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001b531e8a000sm9435065plh.157.2023.08.08.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:11:29 -0700 (PDT)
Date:   Tue, 8 Aug 2023 13:11:27 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: mwifiex: avoid possible NULL skb pointer
 dereference
Message-ID: <ZNKhb2lgSmfEqqsW@google.com>
References: <20230808084431.43548-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808084431.43548-1-dmantipov@yandex.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 08, 2023 at 11:44:27AM +0300, Dmitry Antipov wrote:
> In 'mwifiex_handle_uap_rx_forward()', always check the value
> returned by 'skb_copy()' to avoid potential NULL pointer
> dereference in 'mwifiex_uap_queue_bridged_pkt()', and drop
> original skb in case of copying failure.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 838e4f449297 ("mwifiex: improve uAP RX handling")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/marvell/mwifiex/uap_txrx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> index 04ff051f5d18..454d1c11d39b 100644
> --- a/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> +++ b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c
> @@ -252,7 +252,15 @@ int mwifiex_handle_uap_rx_forward(struct mwifiex_private *priv,
>  
>  	if (is_multicast_ether_addr(ra)) {
>  		skb_uap = skb_copy(skb, GFP_ATOMIC);
> -		mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
> +		if (likely(skb_uap)) {
> +			mwifiex_uap_queue_bridged_pkt(priv, skb_uap);
> +		} else {
> +			mwifiex_dbg(adapter, ERROR,
> +				    "failed to copy skb for uAP\n");
> +			priv->stats.tx_dropped++;

This feels like it should be 'rx_dropped', since we're dropping it
before we done any real "RX" (let alone getting to any forward/outbound
operation). I doubt it makes a big difference overall, but it seems like
the right thing to do.

Otherwise, this looks good; feel free to carry this to a next revision
if you're just changing tx_dropped to rx_dropped:

Acked-by: Brian Norris <briannorris@chromium.org>

> +			dev_kfree_skb_any(skb);
> +			return -1;
> +		}
>  	} else {
>  		if (mwifiex_get_sta_entry(priv, ra)) {
>  			/* Requeue Intra-BSS packet */
> -- 
> 2.41.0
> 
