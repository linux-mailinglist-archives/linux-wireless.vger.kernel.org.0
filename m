Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702F237EDFD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 May 2021 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbhELU6V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 May 2021 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357329AbhELSiZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 May 2021 14:38:25 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5EDC06135C
        for <linux-wireless@vger.kernel.org>; Wed, 12 May 2021 11:35:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id k25so23168266oic.4
        for <linux-wireless@vger.kernel.org>; Wed, 12 May 2021 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZFOyyXBKCVxmTHei8WqaYqRSiqzWm2DLlZyJ5bNF0M=;
        b=UGFmHWnZd5QjL4xBwBlac6osWkLaUHtX6929sOkYWN73jejloRBbtOgHAcLmZJWOQP
         cwP5MKsrrkXojeQ9jJ4ocYHkwCvzNPRq8YshRqBrJUMGkW0tqpMiZxUQLCjCHsxIT6Cv
         xoYjNIDazEhOTfurUtlAK4l2Eb2GBhbUODSHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZFOyyXBKCVxmTHei8WqaYqRSiqzWm2DLlZyJ5bNF0M=;
        b=qh1YaK5rMyXJy/EKVzGjgDS1sLLkfY4gMvU7dqt3GVDgxon2tTfvNgzflcyQPoDb/F
         B+4N5z0lxG53ixRkWNWX6Cl1XisXTpkQ3G7Ee0RAmljQB34nUj6UcJITvH//vmhvjpYz
         Vyx3t/owCLLJWpur03LrQL8W7JHJqTOhMWl9JGiNutOx/4pHVuxwje4rptaFCSRu6MNA
         iWD0mxftkF9vSmk5DwqH1bf4rkiix8uCMCl3+c4hJX9l4ymV+oWcyv9tgSjd86LTCGa3
         LLgbFm1Vwq3e/KA6PRJnqLAiu495I037MIFePOdZ1SeQItZuvij98iLFrtkUD016PzHP
         PkJA==
X-Gm-Message-State: AOAM530hdjX4fb7D6FLRhFBMRHXpoy6lVJDn2Im2MsLyhWgoOlZ2Ey8u
        TksJN4CGus+Q6g8oO/oIbgaFvOOhHtfOIQ==
X-Google-Smtp-Source: ABdhPJx0vjPpDnTix9X4YapDemErOsJHMvi4+9YZ62f8+rpuNzgCrvrCBzfxoJ9yQvTX8NSGGkJw9A==
X-Received: by 2002:a05:6808:193:: with SMTP id w19mr10590276oic.152.1620844536021;
        Wed, 12 May 2021 11:35:36 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id h2sm167298oop.47.2021.05.12.11.35.35
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 11:35:35 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id i81so23155666oif.6
        for <linux-wireless@vger.kernel.org>; Wed, 12 May 2021 11:35:35 -0700 (PDT)
X-Received: by 2002:aca:f144:: with SMTP id p65mr8428701oih.117.1620844534896;
 Wed, 12 May 2021 11:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180259.159598-1-johannes@sipsolutions.net> <20210511200110.11968c725b5c.Idd166365ebea2771c0c0a38c78b5060750f90e17@changeid>
In-Reply-To: <20210511200110.11968c725b5c.Idd166365ebea2771c0c0a38c78b5060750f90e17@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 12 May 2021 11:35:23 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPwAWEEvWBdiLpMrm-PTcSH7QQHwx_T5nxN+faQt=Wi_g@mail.gmail.com>
Message-ID: <CA+ASDXPwAWEEvWBdiLpMrm-PTcSH7QQHwx_T5nxN+faQt=Wi_g@mail.gmail.com>
Subject: Re: [PATCH 14/18] ath10k: drop MPDU which has discard flag set by
 firmware for SDIO
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 11, 2021 at 11:03 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -2312,6 +2312,11 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
>         fw_desc = &rx->fw_desc;
>         rx_desc_len = fw_desc->len;
>
> +       if (fw_desc->u.bits.discard) {
> +               ath10k_dbg(ar, ATH10K_DBG_HTT, "htt discard mpdu\n");
> +               goto err;
> +       }
> +
>         /* I have not yet seen any case where num_mpdu_ranges > 1.
>          * qcacld does not seem handle that case either, so we introduce the
>          * same limitiation here as well.
> diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h b/drivers/net/wireless/ath/ath10k/rx_desc.h
> index f2b6bf8f0d60..705b6295e466 100644
> --- a/drivers/net/wireless/ath/ath10k/rx_desc.h
> +++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
> @@ -1282,7 +1282,19 @@ struct fw_rx_desc_base {
>  #define FW_RX_DESC_UDP              (1 << 6)
>
>  struct fw_rx_desc_hl {
> -       u8 info0;
> +       union {
> +               struct {
> +               u8 discard:1,
> +                  forward:1,
> +                  any_err:1,
> +                  dup_err:1,
> +                  reserved:1,
> +                  inspect:1,
> +                  extension:2;
> +               } bits;
> +               u8 info0;
> +       } u;

Am I misled here, or are you introducing endianness issues here? From C99:

"The order of allocation of bit-fields within a unit (high-order to
low-order or low-order to high-order) is implementation-defined."

Now, we're pretty well attuned to two implementations (big and little
endian), and this should work for the most common one (little endian),
but it's not wise to assume everyone is little endian.

Brian
