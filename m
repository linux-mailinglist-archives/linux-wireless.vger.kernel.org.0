Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85AEBC7E7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504875AbfIXMck (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 08:32:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfIXMck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 08:32:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BA22611D1; Tue, 24 Sep 2019 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569328359;
        bh=Ds7UoBG2rXLNv5U7qrOLRd8QK3yD/meBDUHskysijXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4Yx8Q5FXc6ezi4t0DuiTiWcp2tW8EkNgsXRjusFTes7aIKZlEpWuE93PGBpAcTJm
         EiP0FHdX5f70M9OJa77ojmJ9WMEK6SN5iI+sOWDG0is55lvsv1Cfg6tmtHZFaKygzP
         xn2L642D9YP1rLLe+amRsm/quxu8VDgguuTEmZ90=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 8EA1360A97;
        Tue, 24 Sep 2019 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569328358;
        bh=Ds7UoBG2rXLNv5U7qrOLRd8QK3yD/meBDUHskysijXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E9TEKkWaTOtc8Ip2/wIBMt34VIXuwbOAsz5BpAmKcYI3etv1BEEXMTBux5ARnlOAX
         jK/BGQVFjssgjgtxphVDlRUa76ZP1LGLXDFKbEk/3LqI7BZ95aZVMiwAHOw9u7rrWA
         viBAHiaU8ONJU3XrtOiH8Mp8imijnn2i2nZVbM3I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Sep 2019 20:32:38 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of
 sdio
In-Reply-To: <87sgon8inp.fsf@codeaurora.org>
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
 <87sgon8inp.fsf@codeaurora.org>
Message-ID: <11062c4e1659ac759cb73af7d46a6db2@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-09-23 17:29, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> The bottleneck of throughout on sdio chip is the bus bandwidth, to the
>> patches are all to increase the use ratio of sdio bus.
>> 
>>                       udp-rx    udp-tx    tcp-rx    tcp-tx
>> without patches(Mbps)  320        180       170       151
>> with patches(Mbps)     450        410       400       320
>> 
>> These patches only affect sdio bus chip, explanation is mentioned in 
>> each
>> patch's commit log.
> 
> Below is my summary of the patchset. I recommend splitting these into
> smaller sets, makes it a lot easier to review and apply. And please 
> send
> only one or two patchsets at a time.
> 
> [PATCH v5 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
> 
> Applied.
> 
> Patchset 1:
> 
> [PATCH v5 2/8] ath10k: enable RX bundle receive for sdio
> [PATCH v5 3/8] ath10k: change max RX bundle size from 8 to 32 for sdio
> 
> Reasonal but needs some cleanup.
[PATCH v5 2/8] I will use sk_buff_head to replace the 
ath10k_sdio_rx_request, then it will be simple
[PATCH v5 3/8] FIELD_GET is to >>, not <<, so << still need by my 
understand
> 
> Patchset 2:
> 
> [PATCH v5 4/8] ath10k: add workqueue for RX path of sdio
> 
> Is really another thread needed? We already have one for SDIO.

the SDIO thread is used for async tx, this queue is for RX, and it will 
improve udp rx
from 200Mbps to 400Mbps. And it used the workqueue_aux of ar, not new 
created.
this patch is better to put to Patchset 1, it helps RX, so it should put 
together with the
[PATCH v5 2/8] ath10k: enable RX bundle receive for sdio

> 
> [PATCH v5 6/8] ath10k: add htt TX bundle for sdio
> 
> And again a new thread so that we would have three threads for SDIO? 
> I'm
> not convinced about that.
The thread is for tx complete indication and the thread only used for tx 
bundle, if it does not have
heavy traffic, then it will not bundle, then the thread will not run.
for bundled tx, after bundled, it has max 32 packets in each bundle, the 
tx complete for the 32 packets will cost much time, if not give the tx 
complete task to the thread, then it will much delay the bundle of the 
next packets, then it will drop throughput.
> 
> Patchset 3:
> 
> [PATCH v5 7/8] ath10k: enable alt data of TX path for sdio
> 
> Again another module parameter?
the alt_data could be removed
> 
> [PATCH v5 8/8] ath10k: enable napi on RX path for sdio
> 
> Seems reasonable, but worried about breaking USB.
it can change to check napi enabled, if not, will use old 
ieee80211_rx_ni in ath10k_htt_rx_proc_rx_ind_hl
> 
> Patchset 4:
> 
> [PATCH v5 5/8] ath10k: disable TX complete indication of htt for sdio
> 
> Quite hackish and I need numbers how much it really improves throughput
it will improve throughput,
for udp tx, it can arrive to 400Mbps, if remove this patch, it will drop 
to
130M. it not only remove the tx complete message's bus bandwidth of 
sdio, and it also
has a improvement in firmware's tx path's logic, it will change the 
logic
of tx simple both in firmware and ath10k and faster the tx circle.
And the paramter disable_tx_comp can be removed.
this patch shoud be put in Patchset 2, it help TX, so it is better to 
put together with the
[PATCH v5 6/8] ath10k: add htt TX bundle for sdio.


