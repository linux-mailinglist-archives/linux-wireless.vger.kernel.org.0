Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77179158A30
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 08:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBKHDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 02:03:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBKHDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 02:03:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id 185so5027826pfv.3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2020 23:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZSoX/T69rQ+Ck7xhZRWSOsSLw5fJMwxFZcL7ir96Rw=;
        b=Kmc4/Zl1GoI41XIC0TSseAU7S8vIfxo0vToR33StTc/YtOEm4UcyLFr7oE/U2EkjH0
         O8vAUNitWCeXAWfBiSYBsugXJCz9qun5wY76Rv7jjZThu5eddak8bMSwHIbfJo6kwY4w
         tI+jd3g6u1+nobglsNbL8UX4l9qbQcFXbe81Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZSoX/T69rQ+Ck7xhZRWSOsSLw5fJMwxFZcL7ir96Rw=;
        b=t72rhDBDqXFC4JigCKtDhNWcXb6oLKAZkqux7C1jfs9hFgOxVVyJnC0fqVkWtieQC/
         iG2XuvDLUFN2RUzhELw/GaVrsQjIC4RgcnKVEYPAZ+Oy1BOuvVNperlkH8sUK9sDcSVo
         KvqU6fR/1k1hIxHkNOP3gY/DFuD2FRJRObBs4JaU7AOTz0GkdQUJJK3FJP3CXsl887al
         QtC75hEARGFxTik4uVTMSpPtgqF9KsVdKl8IMFHBcT30PY73I9qcK57N46/XrfA/l3ml
         qzFYf6nXMI5rBWIDv8omdLVF1ajx6fvZzQk6ldDbQZJHFErbmX5REIupDrHPD6lN28KE
         aGJA==
X-Gm-Message-State: APjAAAVKqES0VC+yxInsbTg8DFoPwedshyPTIzvTbpOjhGbtW9UUjUAm
        WLH8X7cSqHD3Y4UXBQopjeSBuvzAcHZF4A==
X-Google-Smtp-Source: APXvYqxixAyN5h2Jo4CX6YxMuAHF3JVKqsZrJj2xcehzsd8p5iogyxGRKyJOY3qvdpJ4Gsgaj5fVIw==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr5498898pgn.275.1581404633807;
        Mon, 10 Feb 2020 23:03:53 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:70db:a5:26c3:9423])
        by smtp.gmail.com with ESMTPSA id k1sm2791653pfg.66.2020.02.10.23.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:03:53 -0800 (PST)
Subject: Re: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for
 sdio
To:     Wen Gong <wgong@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20191128103030.6429-1-wgong@codeaurora.org>
 <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Message-ID: <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org>
Date:   Tue, 11 Feb 2020 15:03:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 11/28/19 6:30 PM, Wen Gong wrote:
> ...
> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
> index a182c0944cc7..c6c4b2a4d20f 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -543,7 +543,35 @@ void ath10k_htt_tx_free(struct ath10k_htt *htt)
>   
>   void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
>   {
> +	struct ath10k_htt *htt = &ar->htt;
> +	struct htt_tx_done tx_done = {0};
> +	struct htt_cmd_hdr *htt_hdr;
> +	struct htt_data_tx_desc *desc_hdr;
> +	u16 flags1;
> +
>   	dev_kfree_skb_any(skb);
> +
> +	if (!htt->disable_tx_comp)
> +		return;
> +
> +	htt_hdr = (struct htt_cmd_hdr *)skb->data;

skb is already freed on the above line (dev_kfree_skb_any) but is still 
used here, should the dev_kfree_skb_any be moved to the end of this 
function?

> +	if (htt_hdr->msg_type != HTT_H2T_MSG_TYPE_TX_FRM)
> +		return;
> +
> +	desc_hdr = (struct htt_data_tx_desc *)
> +		(skb->data + sizeof(*htt_hdr));
> +	flags1 = __le16_to_cpu(desc_hdr->flags1);
> +
> +	ath10k_dbg(ar, ATH10K_DBG_HTT,
> +		   "htt tx complete msdu id:%u ,flags1:%x\n",
> +		   __le16_to_cpu(desc_hdr->id), flags1);
> +
> +	if (flags1 & HTT_DATA_TX_DESC_FLAGS1_TX_COMPLETE)
> +		return;
> +
> +	tx_done.status = HTT_TX_COMPL_STATE_ACK;
> +	tx_done.msdu_id = __le16_to_cpu(desc_hdr->id);
> +	ath10k_txrx_tx_unref(&ar->htt, &tx_done);
>   }
>   
