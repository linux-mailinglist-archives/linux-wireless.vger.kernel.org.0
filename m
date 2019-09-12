Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6752DB118A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfILOyS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 10:54:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33188 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbfILOyS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 10:54:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CDB2B6083C; Thu, 12 Sep 2019 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568300056;
        bh=NBk5oR13bcsUTqIz3QlQRAZKnIqQ4XOZKy0W3KGrYjM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Zr4eLmxmayiDYpFd6lPaPJQPufwUk9cwfiF3ZGCv9LMbQ1KnyqZEGNFpnABufR7Si
         eurHw+CQzxojUdznjeQKGFdX/k97xsKBiI8nve7obZbNjSyjo7ZFyiACbxsf7Dy1gt
         IWsTNsxr0UmPl+1ydlRwKSkHiHUHZlYsTdAsIlok=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32F2060209;
        Thu, 12 Sep 2019 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568300056;
        bh=NBk5oR13bcsUTqIz3QlQRAZKnIqQ4XOZKy0W3KGrYjM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=TGRPPQHxIITs/L0oNoPPvp7zF/O2E7m77s0sf7k3/YOiZdmKrA48bJ1bNZLxYtBvP
         91zNonFS7EexZb1WSLZN6kT70bR+h7AVinFbeCWMRbrm3J1X3JWoKnISNjMWDOR4f/
         nnwIRrPrs9xDvHgnJnO6mqISyY/YvMt5SIFSsrhk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32F2060209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/8] ath10k: adjust skb length in
 ath10k_sdio_mbox_rx_packet
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567679893-14029-2-git-send-email-wgong@codeaurora.org>
References: <1567679893-14029-2-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190912145416.CDB2B6083C@smtp.codeaurora.org>
Date:   Thu, 12 Sep 2019 14:54:16 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

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
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b7139960832e ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet

-- 
https://patchwork.kernel.org/patch/11132657/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

