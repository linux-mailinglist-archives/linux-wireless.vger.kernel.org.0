Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A317D5D3D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjJXVeH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjJXVeF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 17:34:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF8133
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5cd27b1acso41496955ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183242; x=1698788042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzgFevCEBoy3uNYPrdTwG0cJ6YSSUpVWwwpPOjVEOXo=;
        b=UrsQHYjUvTU6nRO+F5HIbo8Kn7YlSd3bp723ISocx5x6L4bdujmvKLROgdZd45Q7Iy
         NdpqM/jt2T8bnu5ZwkK2nQW3gB74zD3lBep5PN5XtakssfDl1XKDDA/wRDEaG2JzDudJ
         MUTWT2bPaPefwDrYxxWqHZXq38l2yaxJKzhP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183242; x=1698788042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzgFevCEBoy3uNYPrdTwG0cJ6YSSUpVWwwpPOjVEOXo=;
        b=BN85TSd9CL6CWuUmNwZ1DmT0pGhL/Dv1iQTAWt5OkvcWISLsJTk4EuAn0cQaYhQjVr
         i2+n+YkyeNvWZuBjdqCM+9lvoF6GwzjqN8odwj73FMmvpxpcrtXMcGSeZ1E4MqIbXfWs
         zQBTF63y/6SZiXBeDaucOkjMpsQ1Ud6rSgpvQ4QOHpCB3juJcrQJlcIA7MChG6ckzR2j
         29EcHr74rWAoGH/CKeTfbZiZv8V0NWIpRlVsWs2kt1nxdHWCuAsD+KAFA5BxlcB83WJZ
         wLzvvAFfAHnbEU6bc31t5b+ChHg0TpQwvlVmFJW+9BufBDMc/ytjh7spgVJqXxJJ26zk
         Ln+Q==
X-Gm-Message-State: AOJu0Yz2Ag9OtG23EVUYvDA6HltEyoiC1+pNGgVJ5v8mGaZzfXkqYeGJ
        344BuLj4usuRH4TAVtlv6Zcjn/KrPyqDNWSytwU=
X-Google-Smtp-Source: AGHT+IG3/Sv64oN0pEa3F6T3eh9NZodgI82qw+e4xbTTKbOvoIpbPuuv5YdPvBGTxmOD/WWxRQbn/g==
X-Received: by 2002:a17:902:e5c3:b0:1c9:aac5:df1a with SMTP id u3-20020a170902e5c300b001c9aac5df1amr16061797plf.51.1698183242169;
        Tue, 24 Oct 2023 14:34:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001c625acfed0sm7857910plb.44.2023.10.24.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:34:01 -0700 (PDT)
Date:   Tue, 24 Oct 2023 14:34:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath10k: replace deprecated strncpy with memcpy
Message-ID: <202310241428.0AA7B80@keescook>
References: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v2-1-4c1f4cd4b4df@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 24, 2023 at 05:42:16PM +0000, Justin Stitt wrote:
> strncpy() is deprecated [1] and we should prefer less ambiguous
> interfaces.
> 
> In this case, arvif->u.ap.ssid has its length maintained by
> arvif->u.ap.ssid_len which indicates it may not need to be
> NUL-terminated. Make this explicit with __nonstring and use a plain old
> memcpy.
> 
> This is also consistent with future copies into arvif->u.ap.ssid:
> 
> 	if (changed & BSS_CHANGED_SSID &&
> 	    vif->type == NL80211_IFTYPE_AP) {
> 		arvif->u.ap.ssid_len = vif->cfg.ssid_len;
> 		if (vif->cfg.ssid_len)
> 			memcpy(arvif->u.ap.ssid, vif->cfg.ssid,
> 			       vif->cfg.ssid_len);
> 		arvif->u.ap.hidden_ssid = info->hidden_ssid;
> 	}
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - update subject to include wifi
> - prefer memcpy() over strtomem() (thanks Kalle, Jeff)
> - rebase onto 6.6-rc7 @d88520ad73b79e71
> - Link to v1: https://lore.kernel.org/r/20231013-strncpy-drivers-net-wireless-ath-ath10k-mac-c-v1-1-24e40201afa3@google.com
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/ath/ath10k/core.h | 2 +-
>  drivers/net/wireless/ath/ath10k/mac.c  | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 4b5239de4018..ba9795a8378a 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -607,7 +607,7 @@ struct ath10k_vif {
>  			u8 tim_bitmap[64];
>  			u8 tim_len;
>  			u32 ssid_len;
> -			u8 ssid[IEEE80211_MAX_SSID_LEN];
> +			u8 ssid[IEEE80211_MAX_SSID_LEN] __nonstring;
>  			bool hidden_ssid;
>  			/* P2P_IE with NoA attribute for P2P_GO case */
>  			u32 noa_len;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 03e7bc5b6c0b..f3f6deb354c6 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -6125,9 +6125,8 @@ static void ath10k_bss_info_changed(struct ieee80211_hw *hw,
>  
>  		if (ieee80211_vif_is_mesh(vif)) {
>  			/* mesh doesn't use SSID but firmware needs it */
> -			strncpy(arvif->u.ap.ssid, "mesh",
> -				sizeof(arvif->u.ap.ssid));
>  			arvif->u.ap.ssid_len = 4;
> +			memcpy(arvif->u.ap.ssid, "mesh", arvif->u.ap.ssid_len);

This is a behavior change, isn't it? i.e. arvif->u.ap.ssid is no longer
zero-padded. Is this actually ok for the driver?

-Kees

-- 
Kees Cook
