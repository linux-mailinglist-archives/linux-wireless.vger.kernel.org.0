Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9007E3F7E0D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 00:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhHYV5B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Aug 2021 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYV5B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Aug 2021 17:57:01 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A365C061757
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 14:56:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l3so771694qtk.10
        for <linux-wireless@vger.kernel.org>; Wed, 25 Aug 2021 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BqZHyCQ+ZtRXhu36KVaGHkhitAs2yNa7TyGZghJpS00=;
        b=W5G2Zj11SONKDaKUAXuJyI7ECC0XlvUKcjisURXCEDHOWJmV/wdW3BQuxClJtlgwGh
         8POCXs0BDHY7R75VzO8D+TnBJyM8NG21+H3PxODoGgeXnvRaVUrym8f/H7zNI7Ra2enl
         2g3BTgL/RJzJzmLnDeZHzfLxM9ME8sEKs3Zw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BqZHyCQ+ZtRXhu36KVaGHkhitAs2yNa7TyGZghJpS00=;
        b=gsRbcnOzvtwKaNKuDDvCIO9V+22iGIQB0r40l5oovG2pTsYyggliRoe+cXGZsc/50p
         SmjPZ5jaErMhsThvV/0epM4xqJ4TaM5hB6ZezHbKcWWe1FsFflFcuI0vslhK3gnTYOU9
         /qyfU+hE3+PIfXQgj6zlhSRfBv99qJKSTvWfXpmyANUbfXxfJ2cqo6HpLdlgTtPwRX2t
         +rY5Oa0gnFb7y2jQyNf71c5Hd/76snO9WEtkHfKD1xTP6ohYbMEa66IV9tatrj0Uxytg
         cDT4R4+Js4Loktp10mfgrhujEChQdteOPwIWT20aKD9mw5drXJ4nPYc7vGze7TQa8Oer
         l5vA==
X-Gm-Message-State: AOAM530iqQ+cyHJQGJKo1aS0/RiJ2CX2SK3ZwJAj4iXvz4egHveCc8K0
        +71ub0kLKJ98yLUPMG3F/ofxeHxSHJ+gKmFkl8E=
X-Google-Smtp-Source: ABdhPJwQfWI7ufnrj99gZ4aNyiNHofH7qULvzyzpRi6m9lvYmbqKKWQ3+Z+7Z+rehISyYjIdJu+hgw==
X-Received: by 2002:a05:622a:120d:: with SMTP id y13mr465870qtx.10.1629928574320;
        Wed, 25 Aug 2021 14:56:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:38c5:675f:d171:ff55:3554:62a5? ([2600:1700:38c5:675f:d171:ff55:3554:62a5])
        by smtp.gmail.com with ESMTPSA id q184sm1013531qkd.35.2021.08.25.14.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 14:56:13 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] ath11k: avoid unnecessary lock contention in
 tx_completion path
To:     P Praneesh <ppranees@codeaurora.org>, kvalo@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
References: <1629884277-18759-1-git-send-email-ppranees@codeaurora.org>
 <1629884277-18759-13-git-send-email-ppranees@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <288e574d-0de0-9002-b853-5fa1db3bd3f7@eero.com>
Date:   Wed, 25 Aug 2021 14:56:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1629884277-18759-13-git-send-email-ppranees@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 8/25/21 2:37 AM, P Praneesh wrote:
> @@ -584,16 +580,15 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
>   			continue;
>   		}
>   
> -		spin_lock_bh(&tx_ring->tx_idr_lock);
> -		msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
missing spin_lock(&tx_ring->tx_idr_lock);here?
> +		msdu = idr_remove(&tx_ring->txbuf_idr, msdu_id);
>   		if (unlikely(!msdu)) {
>   			ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
>   				    msdu_id);
> -			spin_unlock_bh(&tx_ring->tx_idr_lock);
> +			spin_unlock(&tx_ring->tx_idr_lock);
>   			continue;
>   		}
> -		idr_remove(&tx_ring->txbuf_idr, msdu_id);
> -		spin_unlock_bh(&tx_ring->tx_idr_lock);
> +
> +		spin_unlock(&tx_ring->tx_idr_lock);
>   
>   		ar = ab->pdevs[mac_id].ar;
>   
