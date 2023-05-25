Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB3711073
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjEYQIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjEYQH5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 12:07:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F96E57
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 09:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C199F6473E
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 16:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929EBC433EF;
        Thu, 25 May 2023 16:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685030855;
        bh=cgi9jL7KeOFxvFfDYxt1/yJP6pVi7GYwh5qEAHiiARM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=kMPJEV4C5m4UGm5B4P/XQ2Ybsak6LDmDGG7Z1j+tQsRzKmo9NlddTF60lLsLz0SzW
         EDsNC93PX3uvPC//8i1Kj1hjUMVwigWICbW8KGAzQkOWuzxrof3gQ13NB88ZcvTkcL
         4FRNcJIxGhuvjVdHkAFSPsO2nw7gbJRCiRCjefIfJIxfngyyyChnvh8/rPHzMhZ78B
         tB/lA1J6Vi2P9KPVAO/MuzoX8nsLUhe3djIvgxvtDltUfxSsFXeLpBZvrGKg8vNbvF
         boIKg9c5ydSBCuw3V29CLxfib4rX0u1a7OxMDFlW1Kl1RP9GhIxFDUgF0G2GBu1c3L
         cxjieVu9TL8Fw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: rtw89: use struct to access register-based H2C/C2H
References: <20230522122513.13559-1-pkshih@realtek.com>
        <20230522122513.13559-6-pkshih@realtek.com>
Date:   Thu, 25 May 2023 19:07:30 +0300
In-Reply-To: <20230522122513.13559-6-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Mon, 22 May 2023 20:25:13 +0800")
Message-ID: <87cz2ol7i5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> The register-based H2C/C2H are used to exchange commands and events with
> firmware. The exchange data is limited, but it is relatively simple,
> because it can work before HCI initialization. To make these code clean,
> use struct to access them. This patch doesn't change logic at all.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> --- a/drivers/net/wireless/realtek/rtw89/fw.h
> +++ b/drivers/net/wireless/realtek/rtw89/fw.h
> @@ -18,15 +18,51 @@ enum rtw89_fw_dl_status {
>  	RTW89_FWDL_WCPU_FW_INIT_RDY = 7
>  };
>  
> -#define RTW89_GET_C2H_HDR_FUNC(info) \
> -	u32_get_bits(info, GENMASK(6, 0))
> -#define RTW89_GET_C2H_HDR_LEN(info) \
> -	u32_get_bits(info, GENMASK(11, 8))
> +struct rtw89_c2hreg_hdr {
> +	u32 w0;
> +};

Why this is u32? Shouldn't it be __le32?

> +#define RTW89_C2HREG_HDR_FUNC_MASK GENMASK(6, 0)
> +#define RTW89_C2HREG_HDR_ACK BIT(7)
> +#define RTW89_C2HREG_HDR_LEN_MASK GENMASK(11, 8)
> +#define RTW89_C2HREG_HDR_SEQ_MASK GENMASK(15, 12)
> +
> +struct rtw89_c2hreg_phycap {
> +	u32 w0;
> +	u32 w1;
> +	u32 w2;
> +	u32 w3;
> +} __packed;

Here as well? And I saw more in the patch.

Of course these were already there so isn't a problem introduced by this
patchset, but I started wondering if we are missing some little endian
types?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
