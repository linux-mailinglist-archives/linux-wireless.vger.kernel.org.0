Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B547554F65
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFYMzb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 08:55:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfFYMzb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 08:55:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4261D601B4; Tue, 25 Jun 2019 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467330;
        bh=9mHyf51T1LY6v1BR1u/RU6KOZF5ZuRVx48WIzvXtED4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=V8mx96r/5MoFYHD2pXe56dN17nmHh+uWseWk/jLuXnptmLnh259pWffRa7G0h7qom
         mvpaxy/xFJPsIcsrwh3akMTVAwmvMh4Dzglr/HfWbfUmiqvOW8Y6BKasmFU5KbxRnA
         edzEc1Hw+0kR8FnUtqEPOfrSNfgnnH94rbPOazeo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80ABD601E7;
        Tue, 25 Jun 2019 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561467329;
        bh=9mHyf51T1LY6v1BR1u/RU6KOZF5ZuRVx48WIzvXtED4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ojrQLi+R1zq1dXQxP6Pb9isdf0Ob7Ds5lRZWhciqa3X+VujI4Iegk8Kvol5WeHPyn
         8DlqUOJQEr52vZs/Oyq6oMD75ApyKdlpxuA2EjLtgimZStlTmE+njmmzbt2tU3cDW1
         VHVmmFg+yRusm3mJKjreLBJBd8HgZIxyrLA/9ZlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80ABD601E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: acquire lock to fix lockdep's warning
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190506073836.184059-1-tientzu@chromium.org>
References: <20190506073836.184059-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        wgong@codeaurora.org, drinkcat@chromium.org,
        Claire Chang <tientzu@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625125530.4261D601B4@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 12:55:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Claire Chang <tientzu@chromium.org> wrote:

> Lockdep warns at lockdep_assert_held(&ar->data_lock) in
> ath10k_htt_rx_pn_check_replay_hl(). Acquire ar->data_lock before calling
> ath10k_htt_rx_pn_check_replay_hl() to fix it.
> 
> Call trace:
> ath10k_htt_rx_pn_check_replay_hl+0x118/0x134 [ath10k_core]
> ath10k_htt_rx_proc_rx_ind_hl+0xd8/0x250 [ath10k_core]
> ath10k_htt_t2h_msg_handler+0x148/0xf30 [ath10k_core]
> ath10k_htt_htc_t2h_msg_handler+0x24/0x40 [ath10k_core]
> ath10k_sdio_irq_handler+0x374/0xaa4 [ath10k_sdio]
> 
> Fixes: 130c77495708 ("ath10k: add PN replay protection for high latency devices")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

ef9cc0c44394 ath10k: acquire lock to fix lockdep's warning

-- 
https://patchwork.kernel.org/patch/10930667/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

