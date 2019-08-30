Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA88A2D3B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 05:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH3DUK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 23:20:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39287 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfH3DUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 23:20:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so4948720qki.6
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 20:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOp12j+Z6PagrHAr4/H6tX1qM/5TQhQtkLllQ/NqdoI=;
        b=lXzWuHi/midZ8kVg2nAhbyVJc9iNmnYzRN6d6ifSKh+wQ65ECjuBuRbPsTSr1SA8Jj
         2UBpHtgacQ5VH2RCwrVEAZo9MwY4O98wiabwNGORhX8lmmNE5acNdaoMpj8cjZaXCOAb
         cHXLojvQbmhfiRHrO09DgYjojfqbuoWmkc3bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOp12j+Z6PagrHAr4/H6tX1qM/5TQhQtkLllQ/NqdoI=;
        b=ZXucx4atwGlcnw0/DbBgUeWIDBB7GrennPCVqvFEO1RoF6qzuowAyrudYHZkBqKEsZ
         dgPp9RsqlTKM+Wv4Wx+vmOg7UId1tJKP0bJrh2euumujiJaXDU4GvYKab9UmJibS9X/r
         g2bX+ECoqHR3HjCiiVHd0fC82HwdbCZJglhc2cuHbX76q6vvOuZ4XEyFP3UaDZm9UYJ2
         aLn7lNZcW3JuasT+gI3zI7BS6xbd4LI+ZiHyIkERvwROjoNn6/mB6rmL0VBgXkbIG6F0
         YZBaZ+QZHLAPT6TuzJlwIKiY3BenCdFd5xZ5IN+4KI4JqkArPHMnykOTgTpVtPh6OhOQ
         pAhQ==
X-Gm-Message-State: APjAAAWTZ3kk1hUld5zVe6QvD3np33955DWLVW7FikhrxW8ZsB4axa1Y
        1HXgk2s6qV6TNuJV9It0KwG2E1hHiUH37RXmoiK3t65lxOU=
X-Google-Smtp-Source: APXvYqzcR9MUsf6uOMKXU1Pv9jmThUFUVccsrPp0gy/E4OrmBhEy7LUKBqE4bHPYwJzbr9UtnaiVpVWoqVMZAMAn8D4=
X-Received: by 2002:a37:4ed3:: with SMTP id c202mr13141932qkb.457.1567135208855;
 Thu, 29 Aug 2019 20:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org> <1566998177-2658-9-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566998177-2658-9-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 30 Aug 2019 11:19:56 +0800
Message-ID: <CANMq1KBXWydTR50fVqF7ks5gBTpUAS8Ga-8_MzeMGAknnyoVzg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ath10k: enable napi on RX path for sdio
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 30, 2019 at 1:50 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> For tcp RX, the quantity of tcp acks to remote is 1/2 of the quantity
> of tcp data from remote, then it will have many small length packets
> on TX path of sdio bus, then it reduce the RX packets's bandwidth of
> tcp.
>
> This patch enable napi on RX path, then the RX packet of tcp will not
> feed to tcp stack immeditely from mac80211 since GRO is enabled by
> default, it will feed to tcp stack after napi complete, if rx bundle
> is enabled, then it will feed to tcp stack one time for each bundle
> of RX. For example, RX bundle size is 32, then tcp stack will receive
> one large length packet, its length is neary 1500*32, then tcp stack
> will send a tcp ack for this large packet, this will reduce the tcp
> acks ratio from 1/2 to 1/32. This results in significant performance
> improvement for tcp RX.
>
> Tcp rx throughout is 240Mbps without this patch, and it arrive 390Mbps
> with this patch. The cpu usage has no obvious difference with and
> without NAPI.
>
> call stack for each RX packet on GRO path:
> (skb length is about 1500 bytes)
>   skb_gro_receive ([kernel.kallsyms])
>   tcp4_gro_receive ([kernel.kallsyms])
>   inet_gro_receive ([kernel.kallsyms])
>   dev_gro_receive ([kernel.kallsyms])
>   napi_gro_receive ([kernel.kallsyms])
>   ieee80211_deliver_skb ([mac80211])
>   ieee80211_rx_handlers ([mac80211])
>   ieee80211_prepare_and_rx_handle ([mac80211])
>   ieee80211_rx_napi ([mac80211])
>   ath10k_htt_rx_proc_rx_ind_hl ([ath10k_core])
>   ath10k_htt_rx_pktlog_completion_handler ([ath10k_core])
>   ath10k_sdio_napi_poll ([ath10k_sdio])
>   net_rx_action ([kernel.kallsyms])
>   softirqentry_text_start ([kernel.kallsyms])
>   do_softirq ([kernel.kallsyms])
>
> call stack for napi complete and send tcp ack from tcp stack:
> (skb length is about 1500*32 bytes)
>  _tcp_ack_snd_check ([kernel.kallsyms])
>  tcp_v4_do_rcv ([kernel.kallsyms])
>  tcp_v4_rcv ([kernel.kallsyms])
>  local_deliver_finish ([kernel.kallsyms])
>  ip_local_deliver ([kernel.kallsyms])
>  ip_rcv_finish ([kernel.kallsyms])
>  ip_rcv ([kernel.kallsyms])
>  netif_receive_skb_core ([kernel.kallsyms])
>  netif_receive_skb_one_core([kernel.kallsyms])
>  netif_receive_skb ([kernel.kallsyms])
>  netif_receive_skb_internal ([kernel.kallsyms])
>  napi_gro_complete ([kernel.kallsyms])
>  napi_gro_flush ([kernel.kallsyms])
>  napi_complete_done ([kernel.kallsyms])
>  ath10k_sdio_napi_poll ([ath10k_sdio])
>  net_rx_action ([kernel.kallsyms])
>  __softirqentry_text_start ([kernel.kallsyms])
>  do_softirq ([kernel.kallsyms])
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
> v2:no change
> v3:change some code style
>  drivers/net/wireless/ath/ath10k/htt.c    |  2 ++
>  drivers/net/wireless/ath/ath10k/htt.h    |  3 +++
>  drivers/net/wireless/ath/ath10k/htt_rx.c | 45 ++++++++++++++++++++++++++------
>  drivers/net/wireless/ath/ath10k/sdio.c   | 33 +++++++++++++++++++++++
>  4 files changed, 75 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/htt.c b/drivers/net/wireless/ath/ath10k/htt.c
> index 127b4e4..f69346f 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.c
> +++ b/drivers/net/wireless/ath/ath10k/htt.c
> @@ -157,6 +157,8 @@ int ath10k_htt_connect(struct ath10k_htt *htt)
>
>         htt->eid = conn_resp.eid;
>
> +       skb_queue_head_init(&htt->rx_indication_head);
> +
>         if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL) {
>                 ep = &ar->htc.endpoint[htt->eid];
>                 ath10k_htc_setup_tx_req(ep);
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 4851a2e..462a25b 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -1879,6 +1879,8 @@ struct ath10k_htt {
>         struct ath10k *ar;
>         enum ath10k_htc_ep_id eid;
>
> +       struct sk_buff_head rx_indication_head;
> +
>         u8 target_version_major;
>         u8 target_version_minor;
>         struct completion target_version_received;
> @@ -2298,6 +2300,7 @@ int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
>  void ath10k_htt_rx_pktlog_completion_handler(struct ath10k *ar,
>                                              struct sk_buff *skb);
>  int ath10k_htt_txrx_compl_task(struct ath10k *ar, int budget);
> +int ath10k_htt_rx_hl_indication(struct ath10k *ar, int budget);
>  void ath10k_htt_set_tx_ops(struct ath10k_htt *htt);
>  void ath10k_htt_set_rx_ops(struct ath10k_htt *htt);
>  #endif
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> index 09825b1..71b4afe 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -2263,7 +2263,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
>         if (mpdu_ranges->mpdu_range_status == HTT_RX_IND_MPDU_STATUS_TKIP_MIC_ERR)
>                 rx_status->flag |= RX_FLAG_MMIC_ERROR;
>
> -       ieee80211_rx_ni(ar->hw, skb);
> +       ieee80211_rx_napi(ar->hw, NULL, skb, &ar->napi);
>
>         /* We have delivered the skb to the upper layers (mac80211) so we
>          * must not free it.
> @@ -3664,14 +3664,12 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
>                 break;
>         }
>         case HTT_T2H_MSG_TYPE_RX_IND:
> -               if (ar->bus_param.dev_type == ATH10K_DEV_TYPE_HL)
> -                       return ath10k_htt_rx_proc_rx_ind_hl(htt,
> -                                                           &resp->rx_ind_hl,
> -                                                           skb,
> -                                                           HTT_RX_PN_CHECK,
> -                                                           HTT_RX_NON_TKIP_MIC);
> -               else
> +               if (ar->bus_param.dev_type != ATH10K_DEV_TYPE_HL) {
>                         ath10k_htt_rx_proc_rx_ind_ll(htt, &resp->rx_ind);
> +               } else {
> +                       skb_queue_tail(&htt->rx_indication_head, skb);
> +                       return false;
> +               }
>                 break;
>         case HTT_T2H_MSG_TYPE_PEER_MAP: {
>                 struct htt_peer_map_event ev = {
> @@ -3894,6 +3892,37 @@ static int ath10k_htt_rx_deliver_msdu(struct ath10k *ar, int quota, int budget)
>         return quota;
>  }
>
> +int ath10k_htt_rx_hl_indication(struct ath10k *ar, int budget)
> +{
> +       struct htt_resp *resp;
> +       struct ath10k_htt *htt = &ar->htt;
> +       struct sk_buff *skb;
> +       bool release;
> +       int quota = 0;

Don't init to 0.

> +
> +       for (quota = 0; quota < budget; quota++) {
> +               skb = skb_dequeue(&htt->rx_indication_head);
> +               if (!skb)
> +                       break;
> +
> +               resp = (struct htt_resp *)skb->data;
> +
> +               release = ath10k_htt_rx_proc_rx_ind_hl(htt,
> +                                                      &resp->rx_ind_hl,
> +                                                      skb,
> +                                                      HTT_RX_PN_CHECK,
> +                                                      HTT_RX_NON_TKIP_MIC);
> +
> +               if (release)
> +                       dev_kfree_skb_any(skb);
> +
> +               ath10k_dbg(ar, ATH10K_DBG_HTT, "rx indication poll pending count:%d\n",
> +                          skb_queue_len(&htt->rx_indication_head));
> +       }
> +       return quota;
> +}
> +EXPORT_SYMBOL(ath10k_htt_rx_hl_indication);
> +
>  int ath10k_htt_txrx_compl_task(struct ath10k *ar, int budget)
>  {
>         struct ath10k_htt *htt = &ar->htt;
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index c641f1b..23e92ea 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1400,6 +1400,9 @@ static void ath10k_rx_indication_async_work(struct work_struct *work)
>                 spin_lock_bh(&ar_sdio->wr_async_lock_rx);
>         }
>
> +       if (test_bit(ATH10K_FLAG_CORE_REGISTERED, &ar->dev_flags))
> +               napi_schedule(&ar->napi);
> +
>         spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
>  }
>
> @@ -1813,6 +1816,8 @@ static int ath10k_sdio_hif_start(struct ath10k *ar)
>         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>         int ret;
>
> +       napi_enable(&ar->napi);
> +
>         /* Sleep 20 ms before HIF interrupts are disabled.
>          * This will give target plenty of time to process the BMI done
>          * request before interrupts are disabled.
> @@ -1951,6 +1956,9 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
>         }
>
>         spin_unlock_bh(&ar_sdio->wr_async_lock);
> +
> +       napi_synchronize(&ar->napi);
> +       napi_disable(&ar->napi);
>  }
>
>  #ifdef CONFIG_PM
> @@ -2127,6 +2135,26 @@ static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
>
>  #endif /* CONFIG_PM_SLEEP */
>
> +static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
> +{
> +       struct ath10k *ar = container_of(ctx, struct ath10k, napi);
> +       int done;
> +
> +       done = ath10k_htt_rx_hl_indication(ar, budget);
> +       ath10k_dbg(ar, ATH10K_DBG_SDIO, "napi poll: done: %d,budget:%d\n", done, budget);

This is a debug string, but still, please be consistent in spacing:
"napi poll: done: %d, budget: %d\n"

> +
> +       if (done < budget)
> +               napi_complete_done(ctx, done);
> +
> +       return done;
> +}
> +
> +void ath10k_sdio_init_napi(struct ath10k *ar)
> +{
> +       netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
> +                      ATH10K_NAPI_BUDGET);
> +}
> +
>  static int ath10k_sdio_probe(struct sdio_func *func,
>                              const struct sdio_device_id *id)
>  {
> @@ -2152,6 +2180,8 @@ static int ath10k_sdio_probe(struct sdio_func *func,
>                 return -ENOMEM;
>         }
>
> +       ath10k_sdio_init_napi(ar);
> +
>         ath10k_dbg(ar, ATH10K_DBG_BOOT,
>                    "sdio new func %d vendor 0x%x device 0x%x block 0x%x/0x%x\n",
>                    func->num, func->vendor, func->device,
> @@ -2272,6 +2302,9 @@ static void ath10k_sdio_remove(struct sdio_func *func)
>                    func->num, func->vendor, func->device);
>
>         ath10k_core_unregister(ar);
> +
> +       netif_napi_del(&ar->napi);
> +
>         ath10k_core_destroy(ar);
>
>         flush_workqueue(ar_sdio->workqueue);
> --
> 1.9.1
>
