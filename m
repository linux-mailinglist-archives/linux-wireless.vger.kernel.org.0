Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96439F9E0
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2019 07:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfH1Fi1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Aug 2019 01:38:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44862 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfH1Fi1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Aug 2019 01:38:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id y22so1351700qkb.11
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqVuEkRlOaYhngzmtcAqsxbnn3siGKP0NwUwlbzafvY=;
        b=IUwjxC+JW0b9HZ0HUA+2p7kMuPeIm3FolcA1MUxdajpgs62o0c7FWkA3tgfEjftEKl
         FS6lf5R4GTOxPj4E6LRnVnYLgJM84lk0EJVaJjh9OUaqs9nVRGae4Niqzoi/tPp1+bdr
         3FzyxBj+VCSOH+g9wSKmiI1ToRRBA4YtlG1H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqVuEkRlOaYhngzmtcAqsxbnn3siGKP0NwUwlbzafvY=;
        b=uAsegqh2p9ZQUuV8YeFQRdIhnwkUC6LdF3Q+rldpsKultzXMV5XR1RuJaK/XX6golY
         fBYWKqmDhuoZVzSwtMj/qzjsn+D3umwtLhXrk/U30kHsfO2a62a/vNAtPGHmM2Jz5Xs+
         9L0hMMNKry0r8ncR5MpTOW1+gokB7iGjn4gK84k/9iHfYecS8PvI3rnDZ1skHtaLp5af
         aHUZqzKkuufQAx2fpLDwXgGHlIcI6DFbGQH/31cBpy5FNk9wgJsGcir7ZYn39/WsgDj5
         P6WHCIUPP9nYFGNHilwEsY9oZqrzD/UeX0gVQAOpA5lmDMSMUSdwEkjEEv7z6UM7HIcS
         eLvA==
X-Gm-Message-State: APjAAAXPy2aAiB8WH/UqdfGT+BMOWWSY5pF2YAAB9ym81gvOz/cnMt3x
        EkGc660hLSPHWQ+Ws0IymBi4WFGRjoNSkIbcHf+XAQ==
X-Google-Smtp-Source: APXvYqwlr8DVdIV3RJbgkZBogMZkEe6wqR7K+32kIzwLk23v8QTGR2QhTih0cKio5bjifN39cQxGRtmXfoIYq7hwIKk=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr2183346qkb.457.1566970706021;
 Tue, 27 Aug 2019 22:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <1566903707-27536-1-git-send-email-wgong@codeaurora.org> <1566903707-27536-7-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566903707-27536-7-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 28 Aug 2019 13:38:14 +0800
Message-ID: <CANMq1KDJSwyzz2y-yadJPnGijm=G6y0zg1tMZDyacH8a990BOg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ath10k: enable alt data of TX path for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 27, 2019 at 7:02 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> The default credit size is 1792 bytes, but the IP mtu is 1500 bytes,
> then it has about 290 bytes's waste for each data packet on sdio
> transfer path for TX bundle, it will reduce the transmission utilization
> ratio for data packet.
>
> This patch enable the small credit size in firmware, firmware will use
> the new credit size 1556 bytes, it will increase the transmission
> utilization ratio for data packet on TX patch. It results in significant
> performance improvement on TX path.
>
> This patch only effect sdio chip, it will not effect PCI, SNOC etc.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 16 ++++++++++++++++
>  drivers/net/wireless/ath/ath10k/htc.c  | 11 +++++++++--
>  drivers/net/wireless/ath/ath10k/htc.h  | 11 +++++++++--
>  3 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index 351f4ed..7593d19 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -31,6 +31,7 @@
>  static unsigned int ath10k_cryptmode_param;
>  static bool uart_print;
>  static bool disable_tx_comp = true;
> +static bool alt_data = true;
>  static bool skip_otp;
>  static bool rawmode;
>  static bool fw_diag_log;
> @@ -45,6 +46,15 @@
>
>  /* If upper layer need the TX complete status, it can enable tx complete */
>  module_param(disable_tx_comp, bool, 0644);
> +
> +/* alt_data is only used for sdio chip, for previous version of firmware, its
> + * alt data size is 1544 which is not enough for native wifi, so it need to
> + * alt_data for the firmware.
> + * If the firmware has changed alt data size to 1556, then it can enable
> + * alt_data for the firmware.
> + * alt_data will not effect PCI, SNOC etc.
> + */
> +module_param(alt_data, bool, 0644);
>  module_param(skip_otp, bool, 0644);
>  module_param(rawmode, bool, 0644);
>  module_param(fw_diag_log, bool, 0644);
> @@ -701,6 +711,12 @@ static void ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
>          */
>         param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
>
> +       /* If alternate credit size of 1556 as used by SDIO firmware is
> +        * big enough for mac80211 / native wifi frames. enable it
> +        */
> +       if (alt_data && mode == ATH10K_FIRMWARE_MODE_NORMAL)
> +               param |= HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;

else
     param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;

(and remove the mask above)

> +
>         if (mode == ATH10K_FIRMWARE_MODE_UTF)
>                 param &= ~HI_ACS_FLAGS_SDIO_SWAP_MAILBOX_SET;
>         else
> diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
> index e0eb5f0..5cacab6 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.c
> +++ b/drivers/net/wireless/ath/ath10k/htc.c
> @@ -938,12 +938,15 @@ int ath10k_htc_wait_target(struct ath10k_htc *htc)
>          */
>         if (htc->control_resp_len >=
>             sizeof(msg->hdr) + sizeof(msg->ready_ext)) {
> +               htc->alt_data_credit_size =
> +                       __le16_to_cpu(msg->ready_ext.reserved) & 0x0fff;

Please define 0x0fff as a macro.

>                 htc->max_msgs_per_htc_bundle =
>                         min_t(u8, msg->ready_ext.max_msgs_per_htc_bundle,
>                               HTC_HOST_MAX_MSG_PER_RX_BUNDLE);
>                 ath10k_dbg(ar, ATH10K_DBG_HTC,
> -                          "Extended ready message. RX bundle size: %d\n",
> -                          htc->max_msgs_per_htc_bundle);
> +                          "Extended ready message. RX bundle size: %d, alt size:%d\n",
> +                          htc->max_msgs_per_htc_bundle,
> +                          htc->alt_data_credit_size);
>         }
>
>         INIT_WORK(&ar->bundle_tx_work, ath10k_htc_bundle_tx_work);
> @@ -1095,6 +1098,10 @@ int ath10k_htc_connect_service(struct ath10k_htc *htc,
>         ep->tx_credits = tx_alloc;
>         ep->tx_credit_size = htc->target_credit_size;
>
> +       if (conn_req->service_id == ATH10K_HTC_SVC_ID_HTT_DATA_MSG &&
> +           htc->alt_data_credit_size != 0)
> +               ep->tx_credit_size = htc->alt_data_credit_size;
> +
>         /* copy all the callbacks */
>         ep->ep_ops = conn_req->ep_ops;
>
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index d805ea5..f0a9e60af 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -139,8 +139,14 @@ struct ath10k_htc_ready_extended {
>         struct ath10k_htc_ready base;
>         u8 htc_version; /* @enum ath10k_htc_version */
>         u8 max_msgs_per_htc_bundle;
> -       u8 pad0;
> -       u8 pad1;
> +       union {
> +               __le16 reserved;
> +               struct {
> +                       u8 pad0;
> +                       u8 pad1;
> +               } __packed;
> +       } __packed;
> +
>  } __packed;
>
>  struct ath10k_htc_conn_svc {
> @@ -377,6 +383,7 @@ struct ath10k_htc {
>         int total_transmit_credits;
>         int target_credit_size;
>         u8 max_msgs_per_htc_bundle;
> +       int alt_data_credit_size;
>  };
>
>  int ath10k_htc_init(struct ath10k *ar);
> --
> 1.9.1
>
