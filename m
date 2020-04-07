Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589A61A06A9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGFod (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 01:44:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20384 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGFod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 01:44:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586238272; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=W5IAa9bk+3+cH4DC9hzxTpxvIZtx5Bp/SPl+u2EzUnk=;
 b=ILnhKkp2xZCnu/8rEhCg5NtW2QIVwGvUCkhrR0n+oi9kLN5xIFCBGj1Sjx7+sb9aDrnGX3Q9
 l6brq3cyyKSNlWpCgBs2pqxAdF3tdJk9qccW3edqpyzyULntbnq3yUIb8QL2PfOLceenpdFr
 r5/E9TWDgNgcJouH0zkd+FGJd6Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c133f.7f2f479b3c38-smtp-out-n02;
 Tue, 07 Apr 2020 05:44:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99608C433BA; Tue,  7 Apr 2020 05:44:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 076F7C433F2;
        Tue,  7 Apr 2020 05:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 076F7C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 1/4] ath10k: disable TX complete indication of htt for
 sdio
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200212080415.31265-2-wgong@codeaurora.org>
References: <20200212080415.31265-2-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200407054431.99608C433BA@smtp.codeaurora.org>
Date:   Tue,  7 Apr 2020 05:44:31 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For sdio chip, it is high latency bus, all the TX packet's content will
> be tranferred from HOST memory to firmware memory via sdio bus, then it
> need much more memory in firmware than low latency bus chip, for low
> latency chip, such as PCI-E, it only need to transfer the TX descriptor
> via PCI-E bus to firmware memory. For sdio chip, reduce the complexity of
> TX logic will help TX efficiency since its memory is limited, and it will
> reduce the TX circle's time of each packet and then firmware will have more
> memory for TX since TX complete also need memeory.
> 
> This patch disable TX complete indication from firmware for htt data
> packet, it will not have TX complete indication from firmware to ath10k.
> It will cut the cost of bus bandwidth of TX complete and make the TX
> logic of firmware simpler, it results in significant performance
> improvement on TX path.
> 
> Udp TX throughout is 130Mbps without this patch, and it arrives
> 400Mbps with this patch.
> 
> The downside of this patch is the command "iw wlan0 station dump" will
> show 0 for "tx retries" and "tx failed" since all tx packet's status
> is success.
> 
> This patch only effect sdio chip, it will not effect PCI, SNOC etc.
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

This has new warnings:

drivers/net/wireless/ath/ath10k/htt_tx.c: In function 'ath10k_htt_htc_tx_complete':
drivers/net/wireless/ath/ath10k/htt_tx.c:566:30: warning: 'msg_type' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath10k/htt_tx.c:573:6: warning: 'flags1' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/wireless/ath/ath10k/htt_tx.c:577:42: warning: 'desc_hdr' may be used uninitialized in this function [-Wmaybe-uninitialized]

>From what I can see these are false positives, but please do double check that. In
the pending branch I solved it like this:

--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -546,9 +546,9 @@ void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
        struct ath10k_htt *htt = &ar->htt;
        struct htt_tx_done tx_done = {0};
        struct htt_cmd_hdr *htt_hdr;
-       struct htt_data_tx_desc *desc_hdr;
-       u16 flags1;
-       u8 msg_type;
+       struct htt_data_tx_desc *desc_hdr = NULL;
+       u16 flags1 = 0;
+       u8 msg_type = 0;
 
        if (htt->disable_tx_comp) {
                htt_hdr = (struct htt_cmd_hdr *)skb->data;

-- 
https://patchwork.kernel.org/patch/11377827/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
