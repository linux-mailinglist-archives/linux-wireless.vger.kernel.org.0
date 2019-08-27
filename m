Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0A9DEF1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfH0HnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 03:43:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36126 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0HnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 03:43:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so20465506qtc.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GLjerTI/8s78jWdVImYHb6vDr5CKAOLKDouXj6XF4wg=;
        b=jGNOD59hxbMEKMTEhqkr8YlB9MJm3vuCz4IefnMjfcq2rdLduQ1pV51UpLa5Y/W0k5
         GBbwqcfscgSI9eI2Nnryv2mChGpXBCi74oZd7iz+QcLgDUHl/0pWC8qNu2QoVxEaUOLO
         A3al0Y8zUJwpEbIMJMNm/TVRlSssgaa7nj83Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GLjerTI/8s78jWdVImYHb6vDr5CKAOLKDouXj6XF4wg=;
        b=HPFOPzkxvCyoc8vorjjDcljFSZKdTHjrTgT4NYpXj3zm3uHPEC0N6rr2YIVN/NNjMo
         CetcBaN3UwG8gCYm1zIciRuX16o45FXo0ds8vxmF7DawsSP/Cdq3/1mdDBVSQFsviyLA
         38DrcCnNP8qb6Sk0BCeb6Q8YfCJUmhg1oZnLSpCFhNEvjwLtPv5VMHzimS4D99jXVMxE
         fbb81/gOVStqfIiAOZlhHE20fkbUXZh3BRDmOt5gEeFu31Kl5Zzv/Xc+htb6HFCtlkTK
         Qsz2D5yyJqGr577+aolMjHOgGkv7WFLscA51aaW/CSaSw6RHk3/bDMhyDGUPr4px11Ym
         qxPA==
X-Gm-Message-State: APjAAAXdOLo8g6OUPBdzYQVEX9maMANlDjDxL/SAMkcNT/HSqLhQUNIe
        9aZakadlqNApdT28rXH3ayz5Chmu8uiAA+NgyXKCXw==
X-Google-Smtp-Source: APXvYqzvy30JCfqVVeuFlcOBHQ3i0PQt/AxpQOX/ty6j/l02Yy9w3u9OIPdg3ydGrRvap0sN3jacfWAzz3FziDK+cEw=
X-Received: by 2002:a0c:d981:: with SMTP id y1mr7781133qvj.104.1566891781421;
 Tue, 27 Aug 2019 00:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org> <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566302108-18219-3-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Aug 2019 15:42:50 +0800
Message-ID: <CANMq1KBRMnVqw5rcnVcJs1UjYJxh+RqAEKSAjboojoMgJQpSDw@mail.gmail.com>
Subject: Re: [PATCH 2/7] ath10k: change max RX bundle size from 8 to 32 for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2019 at 7:55 PM Wen Gong <wgong@codeaurora.org> wrote:
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
>  drivers/net/wireless/ath/ath10k/htc.h  | 2 +-
>  drivers/net/wireless/ath/ath10k/sdio.c | 5 +++--
>  drivers/net/wireless/ath/ath10k/sdio.h | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index f55d3ca..8c79b9e 100644
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
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index d9395f0..baa6051 100644
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
> @@ -501,6 +501,7 @@ static int ath10k_sdio_mbox_alloc_bundle(struct ath10k *ar,
>         int ret, i;
>
>         *bndl_cnt = FIELD_GET(ATH10K_HTC_FLAG_BUNDLE_MASK, htc_hdr->flags);
> +       *bndl_cnt += (FIELD_GET(GENMASK(3, 2), htc_hdr->flags) << 4);

GENMASK(3, 2): Please define this macro somewhere.

Also, I'd merge the 2 lines in 1.

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
