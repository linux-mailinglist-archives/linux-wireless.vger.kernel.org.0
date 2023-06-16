Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11673732F79
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjFPLKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjFPLKl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 07:10:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE3137
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 04:10:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so4482575e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686913839; x=1689505839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyMpKkbH0XmOyh8QNnC/KLoFb+Js0ZHVPuwpXLgDUOs=;
        b=ipQ8xOfOu7iESiAZ2qumxxp+ISSjk4ITpXmwZTGIUxd9M6WkXAKfyAN+ZqFWTQW4y6
         ueOWQoN1+hetv6u8xjN/9JgnHtahb+T4YO7KM9OsQn7bEKzbndwn8BHO0AA6yWv42III
         1zWsww3LzWeeH8dZdoFPo909hldi1072RlxVXXqiP4lqPllrqq0O/A1nh924xumpNMpo
         Gl+twSzz5qGUNpuoh9xIFCzfvIA0yM10/ISXiZC8cmemxJ/1qvuqyNy78YCwDYIIZbkX
         QkmWZqruj0SAUCOaD5QuHOiuiVy5ptatOfmcjNRvfgjypidj26jPeQKPcImeie/j/N+1
         8Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686913839; x=1689505839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyMpKkbH0XmOyh8QNnC/KLoFb+Js0ZHVPuwpXLgDUOs=;
        b=RmKeDvsrnXC70/Rs91gFt8GnHshTEbM0TuBu3Qj36QKGuB1vXJh5Gg6KsJ4MYmOcql
         XuqymNDTtd3q/uzfaGva0eg5HeOJdor7oRxvQWY9Hcy1IVp2UGYn3a1Kjs5ltIqfSmsl
         5fP54KQakCRSoSOu3HjdXtOpVhURW/qdrCovWFjSbMYlVqUhtp+SSB5P96RfG/z9wrG6
         U0U5CbbEa9hKIiOhnUr72jqc3ROnm8ojQVwLnyCnXlkuiVtUySoSxI5AVTwcp+6FuDXt
         h99yB0iI2J0q7P6VxISXwPZF8vi7q98sKSqIP5C794ewlvuQX0Zyh4Z0dxZxcNzIDT4o
         bYeA==
X-Gm-Message-State: AC+VfDwznTNse4hk70FIHnIlZzJ6pxcUHKH/8RsvmYiFiAPzu6300Zqx
        bdijREQu1H8FF7QiTZX0IjE=
X-Google-Smtp-Source: ACHHUZ6Xy1XN4d2BJsRti7vFSDgxEM+kAvD33xbaJwEjaHUTqb+x2uWWTKZL8K1UBAyLIWDmt49Htw==
X-Received: by 2002:a05:600c:21cc:b0:3f6:13bb:f00b with SMTP id x12-20020a05600c21cc00b003f613bbf00bmr1460052wmj.8.1686913838861;
        Fri, 16 Jun 2023 04:10:38 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.174])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003f8d85b481esm1900111wmc.21.2023.06.16.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:10:38 -0700 (PDT)
Message-ID: <0ce62044-b6a1-ca14-899d-47f7aa807df9@gmail.com>
Date:   Fri, 16 Jun 2023 14:10:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/6] wifi: rtw88: use struct instead of macros to set TX
 desc
To:     Ping-Ke Shih <pkshih@realtek.com>, tony0620emma@gmail.com,
        kvalo@kernel.org
Cc:     phhuang@realtek.com, linux-wireless@vger.kernel.org
References: <20230616034431.17403-1-pkshih@realtek.com>
 <20230616034431.17403-2-pkshih@realtek.com>
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <20230616034431.17403-2-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/06/2023 06:44, Ping-Ke Shih wrote:
> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Remove macros that set TX descriptors. Use struct and
> le32_encode_bits() with mask definitions.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8723d.c |   5 +-
>  drivers/net/wireless/realtek/rtw88/tx.c       |  79 +++++++-----
>  drivers/net/wireless/realtek/rtw88/tx.h       | 121 +++++++-----------
>  drivers/net/wireless/realtek/rtw88/usb.c      |  12 +-
>  4 files changed, 104 insertions(+), 113 deletions(-)
> 

[...]

> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
> index 976eafa739a2d..dbfd5576cc120 100644
> --- a/drivers/net/wireless/realtek/rtw88/usb.c
> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
> @@ -24,11 +24,12 @@ struct rtw_usb_txcb {
>  static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
>  				     struct sk_buff *skb, int agg_num)
>  {
> +	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
>  	struct rtw_dev *rtwdev = rtwusb->rtwdev;
>  	struct rtw_tx_pkt_info pkt_info;
>  
> -	SET_TX_DESC_DMA_TXAGG_NUM(skb->data, agg_num);
> -	pkt_info.pkt_offset = GET_TX_DESC_PKT_OFFSET(skb->data);
> +	le32_replace_bits(tx_desc->w7, agg_num, RTW_TX_DESC_W7_TXDESC_CHECKSUM);

This looks like the wrong mask. Should it be RTW_TX_DESC_W7_DMA_TXAGG_NUM ?

> +	pkt_info.pkt_offset = le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_PKT_OFFSET);
>  	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
>  }
>  
