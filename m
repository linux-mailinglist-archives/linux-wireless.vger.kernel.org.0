Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4C10E815
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 11:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLBKAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 05:00:35 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:53918
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfLBKAe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 05:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575280833;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=pvgALQaUZ3SsfA3R4TZvrNTPXc3QZNqWAwOtLwIfUcs=;
        b=OdpEFtJdsUoe373RjahS9pGFN1m2CPh8+MnZgCYfbtryraG+6hv4AyjannFMheqW
        SyMofhorF19nwHVwCTc/K4IjPbhp2ejHeO+RunDQOa/LnbZrlzDWOjFpOESnSsAbi3j
        I99fGN5oa7pv+U6aAukgYtgJUjsFvTFPPuboLMg0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575280833;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=pvgALQaUZ3SsfA3R4TZvrNTPXc3QZNqWAwOtLwIfUcs=;
        b=G0ZRQJt7EEij+xCErDMggUzb1zSzhKdJpTElSbjj2bLcEe8Mt2cCsfOAyAwVmPQV
        G5EQGeGmwez9F9Ce7FEiv7M/1b++1Am6ejrSaONAsuGNRppJ30Ca2nfXBnQKnJBT4cB
        TLQVlr27BpFTyz75cwrjlnb5H5LvUF6Z8Ucfa9mQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CD34C774C7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] ath10k: enable napi on RX path for sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191014114753.7459-1-wgong@codeaurora.org>
References: <20191014114753.7459-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-ID: <0101016ec60df2ca-bb719640-4e8e-4241-9e3f-3dc2c2c46adf-000000@us-west-2.amazonses.com>
Date:   Mon, 2 Dec 2019 10:00:33 +0000
X-SES-Outgoing: 2019.12.02-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

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
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

cfee8793a74d ath10k: enable napi on RX path for sdio

-- 
https://patchwork.kernel.org/patch/11188393/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

