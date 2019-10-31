Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2361EEAC87
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJaJ1w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 05:27:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfJaJ1v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 05:27:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D31A6085F; Thu, 31 Oct 2019 09:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572514070;
        bh=KF81UVsF6Qwx5Xc3doqe+K7nE+X9JSxLQ+omPxdHx+4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ap71ycd85WmyMagJgG3m6xjEr0Z/+LrcNPt0cd/frYp6tA7Zjc8LbBTJsV9MwW8hz
         e7EihrQ0kfleP6IAR4kl/dEEFym50L104IHaPnB5X8438rr7RKgq/LLlIcm977d9r/
         3uFNSVLcFWDE2cuD5awaE5bl1oWo1dWiLh3+GqQ0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E433A6049C;
        Thu, 31 Oct 2019 09:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572514069;
        bh=KF81UVsF6Qwx5Xc3doqe+K7nE+X9JSxLQ+omPxdHx+4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BQiOzy9uDq2GvORAqaeIYkqNjNMbdneS1gqfalneJfpciT2oY2tE5AfV5nkM4uIuQ
         FU14z92/WIgEItOYyoYGSSaLDoPGGxEf/2vOvKRi7Q3ZWMY6T+dNNw8OM21hd5kiUq
         ek5YEmvPCQ2M2g+BaARvbwLekZuAGf87H1YoU9Pg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E433A6049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6] ath10k: enable napi on RX path for sdio
References: <20191014114753.7459-1-wgong@codeaurora.org>
Date:   Thu, 31 Oct 2019 11:27:46 +0200
In-Reply-To: <20191014114753.7459-1-wgong@codeaurora.org> (Wen Gong's message
        of "Mon, 14 Oct 2019 19:47:53 +0800")
Message-ID: <87tv7p1cz1.fsf@kamboji.qca.qualcomm.com>
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

I have not done thorough review yet, but few quick questions:

This adds a new skb queue ar->htt.rx_indication_head to RX path, but on
one of your earlier patches you also add another skb queue
ar_sdio->rx_head. Is it really necessary to have two separate queues in
RX path? Sounds like extra complexity to me.

The way I have understood that NAPI is used as a mechanism to disable
interrupts on the device and gain throughput from that. But in your
patch the poll function ath10k_sdio_napi_poll() doesn't touch the
hardware at all, it just processes packets from
ar->htt.rx_indication_head queue until budget runs out. I'm no NAPI
expert so I can't claim it's wrong, but at least it feels odd to me.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
