Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4123AE4BDA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394538AbfJYNNa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 09:13:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42000 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731514AbfJYNN3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 09:13:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 990E460779; Fri, 25 Oct 2019 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572009209;
        bh=CiOrvA6VYZbMeIb+pu+Q+ccs4TJbDaUOVs0FyYw9lEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YnQGMIROUG9IUp46fUjBdDCWKX3dX8uz7meYR5e9X+b95lk+LuOullmoxggDSF0lH
         Kz4sQtwzaYtV7STqvL+SneW6op5AR5OSSEiYH/Rg90tEDqCvE8NTU3S5AWvnZtAVY0
         pkz1wBoeb2TEiABZMycb61uGjTq7VkZT4OY88T/8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B98606049C;
        Fri, 25 Oct 2019 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572009206;
        bh=CiOrvA6VYZbMeIb+pu+Q+ccs4TJbDaUOVs0FyYw9lEU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BIKYW97vJVhPTf9kAdjOAZv+1eGkHZwhOCGzlv2yEW9z+c0/FQyNw/Hu7SEwdI7+j
         lNFYAn2HWwlHL9bDaJCRPaU2pKIdA/ezfaUnA+9Qe0TLKp1bmyQgTjBK4Gc9/kJheP
         QuF1x6rnOLK0ihkaeCdWWsfEqqzlkoQ7rWYsCO8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B98606049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] ath10k: enable napi on RX path for sdio
References: <20191014114753.7459-1-wgong@codeaurora.org>
Date:   Fri, 25 Oct 2019 16:13:23 +0300
In-Reply-To: <20191014114753.7459-1-wgong@codeaurora.org> (Wen Gong's message
        of "Mon, 14 Oct 2019 19:47:53 +0800")
Message-ID: <875zkdaryk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

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
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +void ath10k_sdio_init_napi(struct ath10k *ar)
> +{
> +	netif_napi_add(&ar->napi_dev, &ar->napi, ath10k_sdio_napi_poll,
> +		       ATH10K_NAPI_BUDGET);
> +}

This had a new warning:

drivers/net/wireless/ath/ath10k/sdio.c:2053:6: warning: no previous prototype for 'ath10k_sdio_init_napi' [-Wmissing-prototypes]
drivers/net/wireless/ath/ath10k/sdio.c:2053:6: warning: symbol 'ath10k_sdio_init_napi' was not declared. Should it be static?

But as you are calling this function from only ath10k_sdio_probe(), in
the pending branch I removed the function and moved the napi call there.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
