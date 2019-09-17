Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09852B47E5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 09:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbfIQHMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 03:12:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfIQHMD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 03:12:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 775DA611CE; Tue, 17 Sep 2019 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568704322;
        bh=ShYD8stI/e8wrCbX70U2IAUnW5cvRGQsjsgDE8dYptk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VkuWRh6CkllcitfG5x+g/8IEkkrYfxtT6gy5NqVT2BD6/kZ8NfNsZlBx7FQBHBios
         bhcjv5w4wEYddPTLmsEh6QFiwg7BJRuP8nl1WT3ZCR7zvu9QJMa2k1TNMKKnkxJDOF
         HCCGGApZLZ6MtXKQpdPI91ETaGvLbTYbVlchIQsY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8BCBC611CE;
        Tue, 17 Sep 2019 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568704321;
        bh=ShYD8stI/e8wrCbX70U2IAUnW5cvRGQsjsgDE8dYptk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SWK1VxLZ7RFsxFxyRTdENGm5DvKk4eB7wmyABSlgtsdEc51N8bDojtNcrzindMdh1
         qDOtDA35QkuC3mc1qSvCqqWTww9L6PiS13Od01aWpPkVovILnP0h0kiW5mKYtidG+I
         zXF3H9eFbGdJQVTBrsDs5e6HbQFb4vAUfXSuazOA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8BCBC611CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: remove TX lock from ath10k_htt_tx_inc_pending
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190824134857.4094-1-erik.stromdahl@gmail.com>
References: <20190824134857.4094-1-erik.stromdahl@gmail.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     kvalo@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917071202.775DA611CE@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 07:12:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> wrote:

> This commit removes the call to ath10k_mac_tx_lock() from
> ath10k_htt_tx_inc_pending() in case the high water mark is reached.
> 
> ath10k_mac_tx_lock() calls ieee80211_stop_queues() in order to stop
> mac80211 from pushing more TX data to the driver (this is the TX lock).
> 
> If a driver is trying to fetch an skb from a queue while the queue is
> stopped, ieee80211_tx_dequeue() will return NULL.
> 
> So, in ath10k_mac_tx_push_txq(), there is a risk that the call to
> ath10k_htt_tx_inc_pending() results in a stop of the mac80211 TX queues
> just before the skb is fetched.
> 
> This will cause ieee80211_tx_dequeue() to return NULL and
> ath10k_mac_tx_push_txq() to exit prematurely and return -ENOENT.
> Before the function returns ath10k_htt_tx_dec_pending() will be called.
> This call will re-enable the TX queues through ath10k_mac_tx_unlock().
> When ath10k_mac_tx_push_txq() has returned, the TX queue will be
> returned back to mac80211 with ieee80211_return_txq() without the skb
> being properly consumed.
> 
> Since the TX queues were re-enabled in the error exit path of
> ath10k_mac_tx_push_txq(), mac80211 can continue pushing data to the
> driver. If the hardware does not consume the data, the above mentioned
> case will be repeated over and over.
> 
> A case when the hardware is not able to transmit the data from the host
> is when a STA has been dis-associated from an AP and has not yet been
> able to re-associate. In this case there will be no TX_COMPL_INDs from
> the hardware, resulting in the TX counter not be decremented.
> 
> This phenomenon has been observed in both a real and a test setup.
> 
> In order to fix this, the actual TX locking (the call to
> ath10k_mac_tx_lock()) was removed from ath10k_htt_tx_inc_pending().
> Instead, ath10k_mac_tx_lock() is called separately after the skb has
> been fetched (after the call to ieee80211_tx_dequeue()). At this point
> it is OK to stop the queues.
> 
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>

What hardware and firmware versions did you test this? Please always add that
to the commit log.

As Erik mostly works on SDIO I assume PCI is not that well tested. Has anyone
else tried this?

-- 
https://patchwork.kernel.org/patch/11112997/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

