Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0177A2D2B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 05:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfH3DLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 23:11:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33586 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfH3DLR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 23:11:17 -0400
Received: by mail-qk1-f196.google.com with SMTP id w18so4981417qki.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EE6a33UTnmnVHsyTCVKkm4lFvKhlQ+Dl8W8HyUtuDdM=;
        b=AVTftIoEJ8N4aRd1fyoXX6R78LstDc37lMXfjY0Q7QlQVd25rOQfnmsFOEq+nshLIR
         jxacb64XB30J1E9ZfI8xwYd+p220n2wH2urMMqkk19WwTK5zKEAMs4HJ21S14hXuWUA6
         Mcwg47dAYpBkKdM/tCYqiwkxVVmA62I6fIhq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE6a33UTnmnVHsyTCVKkm4lFvKhlQ+Dl8W8HyUtuDdM=;
        b=RHXRe1IESIPzX4G6oxCNUK3TwHIGs1osTdC5/ddl6Iv7pjpy4U4lrKaQXCpOMIQ/WM
         47NLm9h74txzqZ4COnbRJQHet2F161DAMvvaze5APEflW4zfYERcVI5TS5Q3P7clNjc6
         O+Cw+RlrJn1hegDRQyxU+XelNvMe4iXCpGu3CU9FBCfNO1nWaGCBLLtupGkFkGbrpRI4
         b9LEnPdh+5JFidIhe9l/Vc08W0kHUF9rWFCnSw4sL4HOm3r1mhJr+pX2oQjSfKe8kCHN
         3h0gOb5piw3J30Wn2wwAjnb9rsgiP2CU9O8BOGLX++f9rH4AvZEEvMe9fPoSXRC5VVYp
         SG2g==
X-Gm-Message-State: APjAAAXcQDQS2qZzUAdYUYAWzK8ixFNwyCAyZN9QYLc6HfsQu/KCspWM
        Aw1QK2L9DqxMbHgipaKwPZqZgmLqo+RW19ZpRnYzBA==
X-Google-Smtp-Source: APXvYqyEliefPpwh6fJGTur1HRAmTVVPLnpB4Wg0/m0YWnujsWyPAG+uoZL+z0BiL1r+PKLsF2IpjpF/4cKmdd6w4y0=
X-Received: by 2002:a37:4644:: with SMTP id t65mr395488qka.353.1567134676443;
 Thu, 29 Aug 2019 20:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org> <1566998177-2658-4-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566998177-2658-4-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 30 Aug 2019 11:11:05 +0800
Message-ID: <CANMq1KDLXsar1AqU=mfce-2LGD7SRDmC5phkKtz92D3BG35Eog@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2019 at 1:49 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> The max bundle size support by firmware is 32, change it from 8 to 32
> will help performance. This results in significant performance
> improvement on RX path.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
> v2:change macro HTC_GET_BUNDLE_COUNT
> v3:change some code style
>  drivers/net/wireless/ath/ath10k/htc.h  | 8 +++++++-
>  drivers/net/wireless/ath/ath10k/sdio.c | 6 +++---
>  drivers/net/wireless/ath/ath10k/sdio.h | 4 ++--
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index f55d3ca..ffda8bf 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -39,7 +39,7 @@
>   * 4-byte aligned.
>   */
>
> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
>
>  enum ath10k_htc_tx_flags {
>         ATH10K_HTC_FLAG_NEED_CREDIT_UPDATE = 0x01,
> @@ -52,6 +52,12 @@ enum ath10k_htc_rx_flags {
>         ATH10K_HTC_FLAG_BUNDLE_MASK     = 0xF0
>  };
>
> +#define BUNDLE_EXTRA_MASK GENMASK(3, 2)

Well, ATH10K_HTC_FLAG_BUNDLE_MASK is defined in a struct, set to a hex value.
This is a macro, set to a GENMASK() value.

I don't care how you do it, but please be consistent.

In this case, please add ATH10K_HTC_FLAG_BUNDLE_EXTRA_MASK GENMASK =
0x0A in the enum above (sorry, I say structure in my previous
comment).

> +
> +#define HTC_GET_BUNDLE_COUNT(flags) \
> +           (FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, (flags)) +  \
> +           (FIELD_GET(BUNDLE_EXTRA_MASK, (flags)) << 4))
> +
>  struct ath10k_htc_hdr {
>         u8 eid; /* @enum ath10k_htc_ep_id */
>         u8 flags; /* @enum ath10k_htc_tx_flags, ath10k_htc_rx_flags */
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 23c998d..bd808e5 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -24,8 +24,8 @@
>  #include "trace.h"
>  #include "sdio.h"
>
> -#define ATH10K_SDIO_DMA_BUF_SIZE       (32 * 1024)
> -#define ATH10K_SDIO_VSG_BUF_SIZE       (32 * 1024)
> +#define ATH10K_SDIO_DMA_BUF_SIZE       (64 * 1024)
> +#define ATH10K_SDIO_VSG_BUF_SIZE       (64 * 1024)
>
>  /* inlined helper functions */
>
> @@ -495,7 +495,7 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
>  {
>         int ret, i;
>
> -       *bndl_cnt = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, htc_hdr->flags);
> +       *bndl_cnt = HTC_GET_BUNDLE_COUNT(htc_hdr->flags);
>
>         if (*bndl_cnt > HTC_HOST_MAX_MSG_PER_RX_BUNDLE) {
>                 ath10k_warn(ar,
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
> index 4896eca..3ca76c7 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.h
> +++ b/drivers/net/wireless/ath/ath10k/sdio.h
> @@ -89,10 +89,10 @@
>   * to the maximum value (HTC_HOST_MAX_MSG_PER_RX_BUNDLE).
>   *
>   * in this case the driver must allocate
> - * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE) skb's.
> + * (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2) skb's.
>   */
>  #define ATH10K_SDIO_MAX_RX_MSGS \
> -       (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * HTC_HOST_MAX_MSG_PER_RX_BUNDLE)
> +       (HTC_HOST_MAX_MSG_PER_RX_BUNDLE * 2)
>
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL   0x00000868u
>  #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
> --
> 1.9.1
>
