Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCBB103C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 15:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfILNqP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 09:46:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbfILNqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 09:46:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9AB2760790; Thu, 12 Sep 2019 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568295973;
        bh=uEjDwlSOGDk1IXwFFWepFeK+yX9dsUgz95OwsYbtQow=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DL7ZV1AuzLZaYkAxuWjat4DHfaOOjGFW21J4dC8/LHqPvUhKSY7kJju4HX3isYrzU
         pxBfcpkO1Jazx+/O7Eh7kHQX7RL/mgoJeSitZUcJDQScVXyw4v1MAquDa6pkGm6fg/
         iycMy2uhNG1PgCeCTgDa/ADON6sB4mz/dj4ua5Ys=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0393B602FE;
        Thu, 12 Sep 2019 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568295973;
        bh=uEjDwlSOGDk1IXwFFWepFeK+yX9dsUgz95OwsYbtQow=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=DL7ZV1AuzLZaYkAxuWjat4DHfaOOjGFW21J4dC8/LHqPvUhKSY7kJju4HX3isYrzU
         pxBfcpkO1Jazx+/O7Eh7kHQX7RL/mgoJeSitZUcJDQScVXyw4v1MAquDa6pkGm6fg/
         iycMy2uhNG1PgCeCTgDa/ADON6sB4mz/dj4ua5Ys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0393B602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <1567679893-14029-2-git-send-email-wgong@codeaurora.org>
Date:   Thu, 12 Sep 2019 16:46:09 +0300
In-Reply-To: <1567679893-14029-2-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:06 +0800")
Message-ID: <87muf9k4pq.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> From: Nicolas Boichat <drinkcat@chromium.org>
>
> When the FW bundles multiple packets, pkt->act_len may be incorrect
> as it refers to the first packet only (however, the FW will only
> bundle packets that fit into the same pkt->alloc_len).
>
> Before this patch, the skb length would be set (incorrectly) to
> pkt->act_len in ath10k_sdio_mbox_rx_packet, and then later manually
> adjusted in ath10k_sdio_mbox_rx_process_packet.
>
> The first problem is that ath10k_sdio_mbox_rx_process_packet does not
> use proper skb_put commands to adjust the length (it directly changes
> skb->len), so we end up with a mismatch between skb->head + skb->tail
> and skb->data + skb->len. This is quite serious, and causes corruptions
> in the TCP stack, as the stack tries to coalesce packets, and relies
> on skb->tail being correct (that is, skb_tail_pointer must point to
> the first byte_after_ the data).
>
> Instead of re-adjusting the size in ath10k_sdio_mbox_rx_process_packet,
> this moves the code to ath10k_sdio_mbox_rx_packet, and also add a
> bounds check, as skb_put would crash the kernel if not enough space is
> available.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Fixes: 8530b4e7b22bc3b ("ath10k: sdio: set skb len for all rx packets")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> @@ -632,13 +627,29 @@ static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
>  {
>  	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>  	struct sk_buff *skb = pkt->skb;
> +	struct ath10k_htc_hdr *htc_hdr;
>  	int ret;
>  
>  	ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
>  				 skb->data, pkt->alloc_len);
> +
> +	if (!ret) {
> +		/* Update actual length. The original length may be incorrect,
> +		 * as the FW will bundle multiple packets as long as their sizes
> +		 * fit within the same aligned length (pkt->alloc_len).
> +		 */
> +		htc_hdr = (struct ath10k_htc_hdr *)skb->data;
> +		pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
> +		if (pkt->act_len <= pkt->alloc_len) {
> +			skb_put(skb, pkt->act_len);
> +		} else {
> +			ath10k_warn(ar, "rx packet too large (%zu > %zu)\n",
> +				    pkt->act_len, pkt->alloc_len);
> +			ret = -EMSGSIZE;
> +		}
> +	}
> +
>  	pkt->status = ret;
> -	if (!ret)
> -		skb_put(skb, pkt->act_len);
>  
>  	return ret;
>  }

I simplified the error handling in this function to follow the ath10k
style, please check carefully that I didn't create any bugs:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=6e4d2cc5

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
