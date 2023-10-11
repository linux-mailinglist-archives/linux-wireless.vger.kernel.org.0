Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BC37C5898
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjJKPx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 11:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjJKPx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 11:53:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E0A4
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:53:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c9b95943beso15734215ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697039605; x=1697644405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsXZ7DZ6Mvq6e4ootH5Yaud2rG7CcXcXYTpts3RbquQ=;
        b=IvRlXZcbFUc6Ii/eybSWCCxnnrzlXTP+PlvAv3ZEBNipQo1aIvZA4qLrGLfl7k3VCi
         i4XMdvge8o0E9zvLZBpTi+pcRmg7YLBfmSCciwf37S7wzAmdfaqIZMr3Ar9QbA/l54r9
         h70mD0EcRVUIQG1dbycyJs2rDhRPzibqXH9TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039605; x=1697644405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsXZ7DZ6Mvq6e4ootH5Yaud2rG7CcXcXYTpts3RbquQ=;
        b=f8F2hp12JytMjyguKVIKxpkRQLHWSmocl3ii1R3oKBGIVCxE/THTQ2fuVixwIbtxic
         oBINMab0dmRKVCm40PXegCJtGuTLZu8nW34KqDVt2JfkiL5jrgjWVDPI5Ieuq1Z924lt
         sb5bSqLktOAuGIz1VdcioGAQtaiypV0ZWhdcQODKYbaZmJnnt4324iAKJ+f4CJLqMBlc
         gya9clY2CuO/iZqMibEX/HCpF0wlaRb+JQj49EMons4FIwY5Nj7T3zGXGm9B9/mGFyS6
         lUsy8qLrlaiwP/5ownk93H/euVtgEuDknYWBu63sJWHKOwadU845bWYsPqtgun113Iif
         xLgg==
X-Gm-Message-State: AOJu0Yzj+/EhGL6PHrIklYgvzSx9druNt6FM51MU9RZvL/Bvm/KUycFp
        d1FbPPJCXpQoIkvIisfXIvk4Eb4hAtI8A5xO05s=
X-Google-Smtp-Source: AGHT+IH7KchsQA9cUBKp+jfcZlOC7vnVmpcNtmogsO1VLLz8SICUM+L3JBzhugXX+NRbXOH7r+MHng==
X-Received: by 2002:a17:902:e849:b0:1b8:6cae:3570 with SMTP id t9-20020a170902e84900b001b86cae3570mr26295147plg.11.1697039605300;
        Wed, 11 Oct 2023 08:53:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001c5f77e23a8sm3672plb.73.2023.10.11.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:53:24 -0700 (PDT)
Date:   Wed, 11 Oct 2023 08:53:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: rtw89: coex: add annotation __counted_by() for
 struct rtw89_btc_btf_set_slot_table
Message-ID: <202310110850.6A47D35CA@keescook>
References: <20231011063725.25276-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011063725.25276-1-pkshih@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Oct 11, 2023 at 02:37:24PM +0800, Ping-Ke Shih wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> Use struct_size() and flex_array_size() helpers to calculate proper sizes
> for allocation and memcpy().
> 
> Don't change logic at all, and result is identical as before.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Thanks for this!

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
>  drivers/net/wireless/realtek/rtw89/coex.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
> index 4ba8b3df70ae..9f9da122f3f8 100644
> --- a/drivers/net/wireless/realtek/rtw89/coex.c
> +++ b/drivers/net/wireless/realtek/rtw89/coex.c
> @@ -237,7 +237,7 @@ struct rtw89_btc_btf_set_report {
>  struct rtw89_btc_btf_set_slot_table {
>  	u8 fver;
>  	u8 tbl_num;
> -	u8 buf[];
> +	struct rtw89_btc_fbtc_slot tbls[] __counted_by(tbl_num);
>  } __packed;
>  
>  struct rtw89_btc_btf_set_mon_reg {
> @@ -1821,19 +1821,17 @@ static void rtw89_btc_fw_en_rpt(struct rtw89_dev *rtwdev,
>  static void rtw89_btc_fw_set_slots(struct rtw89_dev *rtwdev, u8 num,
>  				   struct rtw89_btc_fbtc_slot *s)
>  {
> -	struct rtw89_btc_btf_set_slot_table *tbl = NULL;
> -	u8 *ptr = NULL;
> -	u16 n = 0;
> +	struct rtw89_btc_btf_set_slot_table *tbl;
> +	u16 n;

Using u16 instead of size_t here makes me nervous, but since "num" is
u8, wrap-around isn't possible. :P

-- 
Kees Cook
