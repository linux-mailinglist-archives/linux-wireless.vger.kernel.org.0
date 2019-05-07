Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4314816551
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2019 16:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGODa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 May 2019 10:03:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGOD3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 May 2019 10:03:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0A77160AA8; Tue,  7 May 2019 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237809;
        bh=eT6ZBtXGR9mYCGZN6jMX7x+xoHA0A+GMjJGBxlXEYVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=M/kiSZ100BaabTirqCEqdCZgrrfh1lT+DXCXqu2NzhXA3GBKfdBHmFzDvgEDz/+Cd
         uiYoSvasYnuTceC0NuAa7pyjX1KKC55uL681YyEB8L53vI157gjr/8hmQegcT4SDPk
         PNGAMFGYm2g2zAiJL9AqVzW1Yo2JWxW/fo8V6dt8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACC7260850;
        Tue,  7 May 2019 14:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557237808;
        bh=eT6ZBtXGR9mYCGZN6jMX7x+xoHA0A+GMjJGBxlXEYVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=pIWpT4xbAz4jfrbFvVSu+Q2YZRca1O5IDSnFREI4NOzSkTYcq6zVZ4K+wWZhc47/w
         d8zFa48i920Gy98nrrLoC3aecZW4msjPVIZCrGrj9Q87gmw6oiUklC2XLTl/HBrIIS
         2yGISxwU8/LXUYxkqAklVwHIoFoE9ooN6Ap809V8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACC7260850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ath10k: add peer id check in ath10k_peer_find_by_id
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556536632-19433-1-git-send-email-wgong@codeaurora.org>
References: <1556536632-19433-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190507140329.0A77160AA8@smtp.codeaurora.org>
Date:   Tue,  7 May 2019 14:03:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For some SDIO chip, the peer id is 65535 for MPDU with error status,
> then test_bit will trigger buffer overflow for peer's memory, if kasan
> enabled, it will report error.
> 
> Reason is when station is in disconnecting status, firmware do not delete
> the peer info since it not disconnected completely, meanwhile some AP will
> still send data packet to station, then hardware will receive the packet
> and send to firmware, firmware's logic will report peer id of 65535 for
> MPDU with error status.
> 
> Add check for overflow the size of peer's peer_ids will avoid the buffer
> overflow access.
> 
> Call trace of kasan:
> dump_backtrace+0x0/0x2ec
> show_stack+0x20/0x2c
> __dump_stack+0x20/0x28
> dump_stack+0xc8/0xec
> print_address_description+0x74/0x240
> kasan_report+0x250/0x26c
> __asan_report_load8_noabort+0x20/0x2c
> ath10k_peer_find_by_id+0x180/0x1e4 [ath10k_core]
> ath10k_htt_t2h_msg_handler+0x100c/0x2fd4 [ath10k_core]
> ath10k_htt_htc_t2h_msg_handler+0x20/0x34 [ath10k_core]
> ath10k_sdio_irq_handler+0xcc8/0x1678 [ath10k_sdio]
> process_sdio_pending_irqs+0xec/0x370
> sdio_run_irqs+0x68/0xe4
> sdio_irq_work+0x1c/0x28
> process_one_work+0x3d8/0x8b0
> worker_thread+0x508/0x7cc
> kthread+0x24c/0x264
> ret_from_fork+0x10/0x18
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

49ed34b835e2 ath10k: add peer id check in ath10k_peer_find_by_id

-- 
https://patchwork.kernel.org/patch/10921671/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

