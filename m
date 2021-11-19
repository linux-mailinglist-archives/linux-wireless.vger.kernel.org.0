Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0540457799
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 21:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKSUJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 15:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKSUJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 15:09:58 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E827C061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 12:06:56 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so18385570ote.8
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 12:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pvxZWWx0k9530SOnlZmD8e6OIIE+pMnqqr7akC7kFsg=;
        b=CLfCZRFoY/KqNEr9DOKFmtsG3UAivBzYg2TSFPdbIKwGCOkLAJbO6IeQbpQssYapAr
         GAfxA4K+J8WmRedCL7mCh2qNuMHaCjYXMKZsNQuDkktrrg8gIbxYnFj7Xp9boP6IyZAP
         y2tWDxk/4KlF1anCT8FyjadaQdFqB0KugLq4cpK9j/Z477aa7fjB2LuTo2uWSM6Wh5aN
         ENfRigqeOnZ2xeRYeFKhWcO0sa7bEccDRazdFvCTakI0cC3uz35ayznHZtVecpgD5zPD
         DjW52V9iHrhEBuW7DSQOfj1Y84DJeLipZu9r4TNEVKAmkISlKC5V+pqkuMpAwA+jxg6R
         9sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pvxZWWx0k9530SOnlZmD8e6OIIE+pMnqqr7akC7kFsg=;
        b=iAfAXOrnCLVG77/4Cd2fhpg6lQhkFycS1K6gKTK5LW8zIfQxmsu/BghX64PiQm7B7z
         gkW1jqlXB3eUkFU+6hocd4yZRQcD1kvem2NeL7HEjOmY9UZw+97gXlQ+Wuc3XUPMQmD4
         ULKWq3luMj7BXFjkURJ7cCTOZ0wmU/I4Nf2gDrkXgabGNLE8JR5Ol+3ZG5a8liS3m1L2
         39ZnfBvWpTHsrWGONw6v3OuVA4NPdKnTPQgsgBajIEKP+xH9g4cZvEwdEh7GeoUp9drz
         yveW8l5AN7Xjfb1TcruTDnjbXgdgwbwFccciWlLsT6T6g2ZSVw8488d3zuDGZoW3H+s4
         ablw==
X-Gm-Message-State: AOAM531ejmEHyCLEV6dH0NO3Ed5l3/pWp64eYkA9SBMjaYdD+ab0O2yB
        y9Ooesmb3BYnvy1uhQpgoF0=
X-Google-Smtp-Source: ABdhPJxCwRtYK+vCIYu5Akxr85IzEqx7vKJY6tcUXJTFjLP+w1mD1hquf7tlGrUvnjaL9a8txTHRFQ==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr7242684otk.289.1637352416046;
        Fri, 19 Nov 2021 12:06:56 -0800 (PST)
Received: from [192.168.1.103] (cpe-24-31-246-181.kc.res.rr.com. [24.31.246.181])
        by smtp.gmail.com with ESMTPSA id c3sm232010oiw.8.2021.11.19.12.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 12:06:55 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <2c354523-1603-0d0b-1880-1ff8dd00a58b@lwfinger.net>
Date:   Fri, 19 Nov 2021 14:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] rtw89: add AXIDMA and TX FIFO dump in mac_mem_dump
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, leo.li@realtek.com
References: <20211119055919.12954-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20211119055919.12954-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/18/21 23:59, Ping-Ke Shih wrote:
> From: Chia-Yuan Li <leo.li@realtek.com>
> 
> The AXIDMA is tx/rx packet transmission between PCIE host
> and device, and TX FIFO is MAC TX data.
> We dump them to ensure these memory buffers correct.
> 
> Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

The code in this patch is fine, but I think you may want to change the commit 
message. Te mo, "We dump them to ensure these memory buffers correct" means that 
the change here will fix the memory buffers. I think you want to say "We dump 
them to verify that these memory buffers are correct." This means that you are 
providing a way to dump the buffers so that their correctness can be determined.

Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net"

Larry

> ---
>   drivers/net/wireless/realtek/rtw89/debug.c |  5 +++++
>   drivers/net/wireless/realtek/rtw89/mac.h   | 10 ++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
> index 29eb188c888c7..dabee20b37c49 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -723,6 +723,7 @@ rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
>   }
>   
>   static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
> +	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
>   	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
>   	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
>   	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR,
> @@ -735,6 +736,10 @@ static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
>   	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR,
>   	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR,
>   	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR,
> +	[RTW89_MAC_MEM_TXD_FIFO_0]	= TXD_FIFO_0_BASE_ADDR,
> +	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR,
> +	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR,
> +	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
>   };
>   
>   static void rtw89_debug_dump_mac_mem(struct seq_file *m,
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> index 6f3db8a2a9c2a..94cd29bd83d77 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -227,6 +227,7 @@ enum rtw89_mac_dbg_port_sel {
>   /* SRAM mem dump */
>   #define R_AX_INDIR_ACCESS_ENTRY 0x40000
>   
> +#define	AXIDMA_BASE_ADDR		0x18006000
>   #define	STA_SCHED_BASE_ADDR		0x18808000
>   #define	RXPLD_FLTR_CAM_BASE_ADDR	0x18813000
>   #define	SECURITY_CAM_BASE_ADDR		0x18814000
> @@ -240,10 +241,15 @@ enum rtw89_mac_dbg_port_sel {
>   #define	DMAC_TBL_BASE_ADDR		0x18800000
>   #define	SHCUT_MACHDR_BASE_ADDR		0x18800800
>   #define	BCN_IE_CAM1_BASE_ADDR		0x188A0000
> +#define	TXD_FIFO_0_BASE_ADDR		0x18856200
> +#define	TXD_FIFO_1_BASE_ADDR		0x188A1080
> +#define	TXDATA_FIFO_0_BASE_ADDR		0x18856000
> +#define	TXDATA_FIFO_1_BASE_ADDR		0x188A1000
>   
>   #define CCTL_INFO_SIZE		32
>   
>   enum rtw89_mac_mem_sel {
> +	RTW89_MAC_MEM_AXIDMA,
>   	RTW89_MAC_MEM_SHARED_BUF,
>   	RTW89_MAC_MEM_DMAC_TBL,
>   	RTW89_MAC_MEM_SHCUT_MACHDR,
> @@ -256,6 +262,10 @@ enum rtw89_mac_mem_sel {
>   	RTW89_MAC_MEM_BA_CAM,
>   	RTW89_MAC_MEM_BCN_IE_CAM0,
>   	RTW89_MAC_MEM_BCN_IE_CAM1,
> +	RTW89_MAC_MEM_TXD_FIFO_0,
> +	RTW89_MAC_MEM_TXD_FIFO_1,
> +	RTW89_MAC_MEM_TXDATA_FIFO_0,
> +	RTW89_MAC_MEM_TXDATA_FIFO_1,
>   
>   	/* keep last */
>   	RTW89_MAC_MEM_LAST,
> 

