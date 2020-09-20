Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681AB2711BD
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Sep 2020 04:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgITCDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Sep 2020 22:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgITCDh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Sep 2020 22:03:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6151C061755;
        Sat, 19 Sep 2020 19:03:36 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b13so5425563qvl.2;
        Sat, 19 Sep 2020 19:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wYkcmiJBC3UmRJJ8A8jHqdwu2K2eI6OMMapMmbHZsAc=;
        b=g2lwKVAZocLXlmT3uCPGEXrGUwv9sO6hruUw3Lkn7JoFlLwz27BjSe9kAFIlNtF4df
         LDDQ6aYnKJeJBtIiKzSDuCdoo7jo61HaRE17q2q0N2uZHD+Djwetkba6T60HhdkuxNFC
         7SlBevuPgpKPRQmZNaqgsHnqy/7nxfBhYR+3eJmggIRuVc+7uyT+FR9L6cDP3+YoVHTQ
         SzegpDBxAUNqPwsm+K5mTTiSU8Z9xp5xDFNY+W9JiBN77ZueNFyu3cjQyPjlbCD7Q8pP
         2xnCXqgCbhVfTgQzdSmta/+Mkw6FmA90QMSLYwejmPMWZ34vdL719P36TjS5omhYZBXY
         uZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wYkcmiJBC3UmRJJ8A8jHqdwu2K2eI6OMMapMmbHZsAc=;
        b=PmQD4YGkk8uF2p4ilQFKCtgQ7Mzra/0f2IiVWzMvXDuw/QiAF5BG6yLQuEkRDyEvSA
         7KoG0szoC6gTM5O29vE3+dSLtfMsurcAObd/1f7Z4N7X8ot6bjtKdvwbCj4U4ADHJ7Us
         dIz4xm5Az3yYh47TFgw3TwG1nJ2+cyAdmYXBt3DkQ/mhTfQsPgMQK3yvcEVrBcLmuDDW
         FGR5HXh4DPfmZT9v0hAq9YkTtW6OhqxKD4or6x2DsKdQnCuewVsbBoIMld74dVLlnzVd
         Io5+p198qGA/5STN7zhOBoUZc/xBPoBs3TxJ1N760sx2UlKFfFVcU1BuWQmsUsyyNsO0
         UKsQ==
X-Gm-Message-State: AOAM532uDn+g/Zkudl8smCmBBLRwkFnQezpX8kUd5pEvhR/4AENVj4jB
        jTtsPuDJVJfXUwhoMzUKyfc=
X-Google-Smtp-Source: ABdhPJxR3/k7aDO54FO9GwsAlCssS4k6XnMLUL45Eiw4vb0ft3hXPrgkwZhc1FEKXesqL+d0ci/C+w==
X-Received: by 2002:a05:6214:a52:: with SMTP id ee18mr24363474qvb.39.1600567415594;
        Sat, 19 Sep 2020 19:03:35 -0700 (PDT)
Received: from [192.168.1.181] (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id q35sm6061142qtd.75.2020.09.19.19.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 19:03:34 -0700 (PDT)
Subject: Re: [PATCH] wireless: ath9k: hif_usb: fix race condition between
 usb_get_urb() and usb_kill_anchored_urbs()
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        syzkaller-bugs@googlegroups.com,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
References: <20200911071427.32354-1-brookebasile@gmail.com>
From:   Brooke Basile <brookebasile@gmail.com>
Message-ID: <535351e1-90e3-ceb6-3d0a-a445a6d9582c@gmail.com>
Date:   Sat, 19 Sep 2020 22:03:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911071427.32354-1-brookebasile@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/11/20 3:14 AM, Brooke Basile wrote:
> Calls to usb_kill_anchored_urbs() after usb_kill_urb() on multiprocessor
> systems create a race condition in which usb_kill_anchored_urbs() deallocates
> the URB before the completer callback is called in usb_kill_urb(), resulting
> in a use-after-free.
> To fix this, add proper lock protection to usb_kill_urb() calls that can
> possibly run concurrently with usb_kill_anchored_urbs().
> 
> Reported-by: syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=cabffad18eb74197f84871802fd2c5117b61febf
> Signed-off-by: Brooke Basile <brookebasile@gmail.com>
> ---
>   drivers/net/wireless/ath/ath9k/hif_usb.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index 3f563e02d17d..2ed98aaed6fb 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -449,10 +449,19 @@ static void hif_usb_stop(void *hif_handle)
>   	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> 
>   	/* The pending URBs have to be canceled. */
> +	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
>   				 &hif_dev->tx.tx_pending, list) {
> +		usb_get_urb(tx_buf->urb);
> +		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
>   		usb_kill_urb(tx_buf->urb);
> +		list_del(&tx_buf->list);
> +		usb_free_urb(tx_buf->urb);
> +		kfree(tx_buf->buf);
> +		kfree(tx_buf);
> +		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	}
> +	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> 
>   	usb_kill_anchored_urbs(&hif_dev->mgmt_submitted);
>   }
> @@ -762,27 +771,37 @@ static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
>   	struct tx_buf *tx_buf = NULL, *tx_buf_tmp = NULL;
>   	unsigned long flags;
> 
> +	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
>   				 &hif_dev->tx.tx_buf, list) {
> +		usb_get_urb(tx_buf->urb);
> +		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
>   		usb_kill_urb(tx_buf->urb);
>   		list_del(&tx_buf->list);
>   		usb_free_urb(tx_buf->urb);
>   		kfree(tx_buf->buf);
>   		kfree(tx_buf);
> +		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	}
> +	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> 
>   	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	hif_dev->tx.flags |= HIF_USB_TX_FLUSH;
>   	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> 
> +	spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
>   				 &hif_dev->tx.tx_pending, list) {
> +		usb_get_urb(tx_buf->urb);
> +		spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
>   		usb_kill_urb(tx_buf->urb);
>   		list_del(&tx_buf->list);
>   		usb_free_urb(tx_buf->urb);
>   		kfree(tx_buf->buf);
>   		kfree(tx_buf);
> +		spin_lock_irqsave(&hif_dev->tx.tx_lock, flags);
>   	}
> +	spin_unlock_irqrestore(&hif_dev->tx.tx_lock, flags);
> 
>   	usb_kill_anchored_urbs(&hif_dev->mgmt_submitted);
>   }
> --
> 2.28.0
> 

Hi,

Just wanted to check on the status of this patch, if there's anything 
wrong I'm happy to make it right.
Sorry to bother!

Best,
Brooke Basile
