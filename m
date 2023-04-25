Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FA6EE539
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjDYQEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 12:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjDYQEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 12:04:21 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F114F5B
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 09:04:17 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-18ecdb1f2aaso5611984fac.1
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682438656; x=1685030656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Hly5uuBTfc4rAD7PMAe9rPQX2/9L+OPO0xvElZZMEA=;
        b=O0yOtDdWSMV53DueZOfEQ/G4TfooMStlKXrbPrTdVz6+6b/WM5X/tSDZGihU3fmGCl
         ETGYUTFt0PNijFQ15jkhuExrviIZsNLKot6RZI4EyB8RBK+9e5gJA03zTX/dupXoXFrh
         Qrnz0AxWHrz7Hg4sckzsLu2Eb/yz9IewFokgSCZ2a2IbN6LkbDYesOYa5hWfcJDMBORD
         dW+Bz90LWer1P6qSbzqdut7EXXuopqHImp0G0InlmU3e03o7c5807mQa+O/kSE+Q1TSW
         OdY2u0JYTDYGALk2Vj8rSIZfHUr5uGxOn2PxLKcbSl4pBXSjFarA6Ba5XYctQvZGIibs
         3qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682438656; x=1685030656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Hly5uuBTfc4rAD7PMAe9rPQX2/9L+OPO0xvElZZMEA=;
        b=YAClHQNAoBxmZ/9oQ+Vj/cyl61rQbNwhaJiguiPJG2DL18H0GfP9370+YNTOHEEQ+O
         N7G3pUGyXc9rlBfHS227Thfdll5L1a0HcYx8YZaJdrcCg4inZNL+cN8d6Aj7YYGQ0UJb
         PPhekIqLQfbcm/VDIHUIA4jagJHl95JuG5aSNDTwRtRP2DWCit4npUMfBjuwuZtbrKVO
         qH8M19T3/CmPR3gXnidXvVarwCWUextB9Ntexua0YP/8KRrgTbTb0k2JtrH49OsactC5
         r1Q7e/CrwZaREBmmWKjyL7bLzgutFX4NmgNbyD6DzGJmQsjCKfJeQn9yxLdkntt5hEW/
         JqzQ==
X-Gm-Message-State: AAQBX9fMUOYILjZcRgsob5/D/Eg1+4heplxzFWoazpMwggzotYRLX9A3
        bIL0/FuEuEiETJWkaNRKC4w=
X-Google-Smtp-Source: AKy350btTEYcfino+TZxwUz2/yFLP9aKsB3lfsl9D0Q8gZTiyyYqNTXwA3JhdsHaTqZX8yoQ65hmmw==
X-Received: by 2002:a4a:e881:0:b0:547:9285:b099 with SMTP id g1-20020a4ae881000000b005479285b099mr3717756ooe.4.1682438655896;
        Tue, 25 Apr 2023 09:04:15 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id p37-20020a4a95e8000000b0051134f333d3sm6109442ooi.16.2023.04.25.09.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:04:15 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <2784bfc8-9c5a-8e0c-aa0c-0864078e31b7@lwfinger.net>
Date:   Tue, 25 Apr 2023 11:04:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused
 by access null page
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org
References: <20230421015357.13940-1-pkshih@realtek.com>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230421015357.13940-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/20/23 20:53, Ping-Ke Shih wrote:
> Though SER can recover this case, traffic can get stuck for a while. Fix it
> by adjusting page quota to avoid hardware access null page of CMAC/DMAC.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>   drivers/net/wireless/realtek/rtw89/mac.c      |  4 +++
>   drivers/net/wireless/realtek/rtw89/mac.h      |  2 ++
>   drivers/net/wireless/realtek/rtw89/rtw8852b.c | 28 +++++++++----------
>   3 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index b8019cfc11b20..512de491a064b 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -1425,6 +1425,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
>   	.wde_size4 = {RTW89_WDE_PG_64, 0, 4096,},
>   	/* PCIE 64 */
>   	.wde_size6 = {RTW89_WDE_PG_64, 512, 0,},
> +	/* 8852B PCIE SCC */
> +	.wde_size7 = {RTW89_WDE_PG_64, 510, 2,},
>   	/* DLFW */
>   	.wde_size9 = {RTW89_WDE_PG_64, 0, 1024,},
>   	/* 8852C DLFW */
> @@ -1449,6 +1451,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
>   	.wde_qt4 = {0, 0, 0, 0,},
>   	/* PCIE 64 */
>   	.wde_qt6 = {448, 48, 0, 16,},
> +	/* 8852B PCIE SCC */
> +	.wde_qt7 = {446, 48, 0, 16,},
>   	/* 8852C DLFW */
>   	.wde_qt17 = {0, 0, 0,  0,},
>   	/* 8852C PCIE SCC */
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
> index a8d9847ef0b49..6ba633ccdd037 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.h
> +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> @@ -792,6 +792,7 @@ struct rtw89_mac_size_set {
>   	const struct rtw89_dle_size wde_size0;
>   	const struct rtw89_dle_size wde_size4;
>   	const struct rtw89_dle_size wde_size6;
> +	const struct rtw89_dle_size wde_size7;
>   	const struct rtw89_dle_size wde_size9;
>   	const struct rtw89_dle_size wde_size18;
>   	const struct rtw89_dle_size wde_size19;
> @@ -804,6 +805,7 @@ struct rtw89_mac_size_set {
>   	const struct rtw89_wde_quota wde_qt0;
>   	const struct rtw89_wde_quota wde_qt4;
>   	const struct rtw89_wde_quota wde_qt6;
> +	const struct rtw89_wde_quota wde_qt7;
>   	const struct rtw89_wde_quota wde_qt17;
>   	const struct rtw89_wde_quota wde_qt18;
>   	const struct rtw89_ple_quota ple_qt4;
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
> index eaa2ea0586bc6..6da1b603a9a95 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
> @@ -18,25 +18,25 @@
>   	RTW8852B_FW_BASENAME "-" __stringify(RTW8852B_FW_FORMAT_MAX) ".bin"
>   
>   static const struct rtw89_hfc_ch_cfg rtw8852b_hfc_chcfg_pcie[] = {
> -	{5, 343, grp_0}, /* ACH 0 */
> -	{5, 343, grp_0}, /* ACH 1 */
> -	{5, 343, grp_0}, /* ACH 2 */
> -	{5, 343, grp_0}, /* ACH 3 */
> +	{5, 341, grp_0}, /* ACH 0 */
> +	{5, 341, grp_0}, /* ACH 1 */
> +	{4, 342, grp_0}, /* ACH 2 */
> +	{4, 342, grp_0}, /* ACH 3 */
>   	{0, 0, grp_0}, /* ACH 4 */
>   	{0, 0, grp_0}, /* ACH 5 */
>   	{0, 0, grp_0}, /* ACH 6 */
>   	{0, 0, grp_0}, /* ACH 7 */
> -	{4, 344, grp_0}, /* B0MGQ */
> -	{4, 344, grp_0}, /* B0HIQ */
> +	{4, 342, grp_0}, /* B0MGQ */
> +	{4, 342, grp_0}, /* B0HIQ */
>   	{0, 0, grp_0}, /* B1MGQ */
>   	{0, 0, grp_0}, /* B1HIQ */
>   	{40, 0, 0} /* FWCMDQ */
>   };
>   
>   static const struct rtw89_hfc_pub_cfg rtw8852b_hfc_pubcfg_pcie = {
> -	448, /* Group 0 */
> +	446, /* Group 0 */
>   	0, /* Group 1 */
> -	448, /* Public Max */
> +	446, /* Public Max */
>   	0 /* WP threshold */
>   };
>   
> @@ -49,13 +49,13 @@ static const struct rtw89_hfc_param_ini rtw8852b_hfc_param_ini_pcie[] = {
>   };
>   
>   static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
> -	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
> -			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
> -			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
> +	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size7,
> +			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
> +			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
>   			   &rtw89_mac_size.ple_qt58},
> -	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size6,
> -			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
> -			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
> +	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size7,
> +			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt7,
> +			   &rtw89_mac_size.wde_qt7, &rtw89_mac_size.ple_qt18,
>   			   &rtw89_mac_size.ple_qt_52b_wow},
>   	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
>   			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

This patch has now been added to the repo at
https://github.com/lwfinger/rtw89.git.

Although it has been applied there for only a couple of days, it has fixed 
timing problems on several new HP laptops [1][2].

My recommendation is that this be designated a "Fixes:" patch, be applied to 
kernel 6.4, and be sent to 6.3 through the "Stable" mechanism.

Larry

[1] https://github.com/lwfinger/rtw89/issues/226#issuecomment-1520776761
[2] https://github.com/lwfinger/rtw89/issues/240

