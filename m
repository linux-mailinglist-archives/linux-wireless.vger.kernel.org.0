Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC04E0198
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 12:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfJVKHr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 06:07:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43220 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJVKHr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 06:07:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id t84so13631318oih.10
        for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2019 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iFTeSU9DK9ebNJwCkq6A2UglnA/84QdLInUE+UVt72Q=;
        b=GLvaM+emlsDUj6Xx9I/LNo1xIxNCSAf5UYV4VRs5hw48hWzheIvw3/mg7Fe4NpNjne
         7tUEvHhvrLgivW2XZxBrYgJMDsrDhcGhXybAMvxodIAhIiawPCSZn8Wu+ZpKlz516lQ8
         +UrDGEamtRGL1IMzJZ5d3L2KBOuWT0oxMaXgBlWn1Oab5JzxCioQqfUqldZ6FG/Fmt1g
         YQ/aY+dW4QiSKzHkQEvBQxue25Ec/J+1TRXE989utfeHrH2HkEfecOb5t1ARKXdsWeH6
         c6BIMUY7+y9HqjjGuigZX772gK1SbBU9+xAljSMEz5YpdB0liu+isDe6/T96EPfsVrjx
         X3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iFTeSU9DK9ebNJwCkq6A2UglnA/84QdLInUE+UVt72Q=;
        b=eTx+MQwIG6Ql4b7uP4bn397b/goNLMaSyJofYKIxjnYyN2B138yaBQEeBFbq/A+ZIn
         rvqwXifu9JE9CHPCIL8I4HZder0ZsXW05Uz+bzfgf1FqzEV7EgI8wUOxohz5cVnQmt2I
         HhnH04TtaaXqSP6+1iPjWvj3zBtFxjpv+8f3va5KH/UqyCt6Tp4D1XtXWWfv5NUXUZqI
         JaM6/xFJOPSAUiAXmLKl+SwU8YD6tKhDPewpaWGDEsSi56hDPtrkXwYcpiJwE1DhKX0S
         hLe2kt3O9draAmnW3RajR9wRa0cmBMeYGndh9CbZrNiYb1Behi0WNnMUCbZcAIqLcGNX
         XXxA==
X-Gm-Message-State: APjAAAUe5nsFnl531Qdbw9Vg+nCkne3iex6prpTTSmpLA5tLrJNqpV+Y
        bkVMHdbs81VD8a/HkJcyJvDFPTF754wZTzZeoKE=
X-Google-Smtp-Source: APXvYqwZwk63iNNN4Hs2V0NWyfBlNKBesMXZy+huRrLlYqynjtIPveX6tpdEvoVLg+oIOs3+icmF89FRFb8Tg+CxDe8=
X-Received: by 2002:a05:6808:aad:: with SMTP id r13mr2248651oij.30.1571738864718;
 Tue, 22 Oct 2019 03:07:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Tue, 22 Oct 2019 03:07:44
 -0700 (PDT)
In-Reply-To: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
References: <1571734629-18028-1-git-send-email-zhichen@codeaurora.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 22 Oct 2019 12:07:44 +0200
Message-ID: <CAKR_QVLDFBVMDDP4mPYVNdpT9TA3podNeQMpVJQwE7A5eG=0kA@mail.gmail.com>
Subject: Re: [PATCH RFC] Revert "ath10k: fix DMA related firmware crashes on
 multiple devices"
To:     Zhi Chen <zhichen@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 22/10/2019, Zhi Chen <zhichen@codeaurora.org> wrote:
> This reverts commit 76d164f582150fd0259ec0fcbc485470bcd8033e.
> PCIe hung issue was observed on multiple platforms. The issue was
> reproduced
> when DUT was configured as AP and associated with 50+ STAs.
>
> With PCIe protocol analyzer, we can see DMA Read crossing 4KB boundary when
> issue happened. It broke PCIe spec and caused PCIe stuck.
>
> Tested:  IPQ8064 + QCA9984 with firmware 10.4-3.10-00047
>          QCS404 + QCA9984 with firmware 10.4-3.9.0.2--00044
>          Synaptics AS370 + QCA9888  with firmware 10.4-3.9.0.2--00040
>
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/hw.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h
> b/drivers/net/wireless/ath/ath10k/hw.h
> index 35a3623..17f620b 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -753,7 +753,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
>  #define TARGET_10X_MAX_FRAG_ENTRIES		0
>
>  /* 10.2 parameters */
> -#define TARGET_10_2_DMA_BURST_SIZE		0
> +#define TARGET_10_2_DMA_BURST_SIZE		1
>
>  /* Target specific defines for WMI-TLV firmware */
>  #define TARGET_TLV_NUM_VDEVS			4
> @@ -813,7 +813,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
>
>  #define TARGET_10_4_TX_DBG_LOG_SIZE		1024
>  #define TARGET_10_4_NUM_WDS_ENTRIES		32
> -#define TARGET_10_4_DMA_BURST_SIZE		0
> +#define TARGET_10_4_DMA_BURST_SIZE		1
>  #define TARGET_10_4_MAC_AGGR_DELIM		0
>  #define TARGET_10_4_RX_SKIP_DEFRAG_TIMEOUT_DUP_DETECTION_CHECK 1
>  #define TARGET_10_4_VOW_CONFIG			0
> --
> 2.7.4
>
>
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
>

What about main and 10x firmware branch?
