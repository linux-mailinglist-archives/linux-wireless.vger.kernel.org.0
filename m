Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB45F9C51
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiJJJ6j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJJJ6h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 05:58:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E595F21F
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:58:36 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id d26so16626122eje.10
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q71cyzrb77lC3RZ2QmN90g4mf6C9J+uErMbuRdb+UyA=;
        b=CdmbPbhCuDlNEBLGMsF4OBOkokeLaTUyaKWHRwrEbpq/di9WXzUpBwfst5WGRsbIw5
         H/50DMTLeqG2cPhUgrMlwBzvm6axyAZOP9OfWsVDb9HiigrjN3CKBD4ucFcNDccg1N1A
         386NHyMh09HtFsqCM+Z2ZYqW00xNpCiNFAJ7K/ZWurdGW+8cHl/sp/pkOXFh/HcSAh78
         VeWBeJsiqGJChqDn687O9ljDg2Io2SHZs95z78/lQAT84LjMOoZ4/Z8CtvLqi7ZEjD3W
         ZmfxMHL1yXITFVwX7/5ysGT/5X7ULzCjdQzUwP6ZoiRDwQBmcq+8amQuLulmFWHFV9x+
         wcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q71cyzrb77lC3RZ2QmN90g4mf6C9J+uErMbuRdb+UyA=;
        b=OuSQXha9i7Du1cQBsuESi7WEZJp1UQoj5GsuyjVdbpqSMJUUe1voHJPFIomhMJOeYo
         CKesfbXZ+tVE4VrauTB3x7iG+CmH5tRTcRLntw73pVGZ5kKm/GM49Xu0eceC2c0hWyyr
         tWh3h8uexAtUULZ9yM0LsuoI1wVjt2BPSn2u7sx+6n3jxSq5X9XXECSprSTawkJxp9ks
         kHkr26bLavdeUXZqWHj0bRQnypyQ9CbZc+DachvF6wVfd02WX1ZvGb+mp62gY0+EnZjn
         lbj/mv9TCa3V6UnatZrW59ua2k1WZCQikf2jE/1FH4vwuEgWV6Az7nvCKsbtHgR/CtJ1
         5okw==
X-Gm-Message-State: ACrzQf1D0gwR6PRXnlLLAU924/LFHA1CaGJSHGjGXm5XuacVUn2EuXLz
        aXcP5hm+sjUq4tOJaWCZFKg=
X-Google-Smtp-Source: AMsMyM4SqOFu9Sw5ciaQAmd5JSZHkkBu6q30WqzwlF/F6znqSPHvNcTMUmGkIfTuuUFT6QNSrKtyCQ==
X-Received: by 2002:a17:906:8a61:b0:78d:9d00:c906 with SMTP id hy1-20020a1709068a6100b0078d9d00c906mr7347464ejc.321.1665395914951;
        Mon, 10 Oct 2022 02:58:34 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id kz9-20020a17090777c900b007806c1474e1sm5022267ejc.127.2022.10.10.02.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 02:58:34 -0700 (PDT)
Message-ID: <627eaf57-09f7-feff-92e2-be88ebd4fe13@gmail.com>
Date:   Mon, 10 Oct 2022 11:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/3] brcmfmac: return error when getting invalid
 max_flowrings from dongle
Content-Language: en-US
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
References: <20220929031001.9962-1-ian.lin@infineon.com>
 <20220929031001.9962-3-ian.lin@infineon.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220929031001.9962-3-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 5:10 AM, Ian Lin wrote:
> From: Wright Feng <wright.feng@cypress.com>
> 
> When firmware hit trap at initialization, host will read abnormal
> max_flowrings number from dongle, and it will cause kernel panic when
> doing iowrite to initialize dongle ring.
> To detect this error at early stage, we directly return error when getting
> invalid max_flowrings(>256).
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 2b7ebbd7b5b4..1becd50038ab 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -1228,6 +1228,10 @@ static int brcmf_pcie_init_ringbuffers(struct brcmf_pciedev_info *devinfo)
>   				BRCMF_NROF_H2D_COMMON_MSGRINGS;
>   		max_completionrings = BRCMF_NROF_D2H_COMMON_MSGRINGS;
>   	}
> +	if (max_flowrings > 256) {
This limit is a bit of a magic value. I do know there are chipsets that 
support more that 256 flowrings so this is a hard limitation. I should 
really get the multi-vendor support in place so we can have the 
limitation only for Infineon/Cypress chips. I will try to revive that 
thread.

Regards,
Arend
