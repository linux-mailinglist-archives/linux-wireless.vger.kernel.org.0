Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83998A7B95
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 08:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfIDGUp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 02:20:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDGUp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 02:20:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83A9D615B0; Wed,  4 Sep 2019 06:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567578044;
        bh=tD/HhnZjMDwOggSgTBR2yklwYyvJy/plqEZsXDK1rMQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Y8cs/LMEHSk+fZ3Yg6c6p6oJ4ChNN9MtvOQN6rVDphmpiqVcNZRw2pIzPMuKAyiKy
         41mD2s6/mrU78y8E91O3zF7Q0R/10r9KsC/nEOrm1eIB/0Stk4rhDRIxClmiJsgBhg
         VBkup6Mz5DS+mDhEkNK0QXhy4Mky36fufBkVcgQM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7AFCE61577;
        Wed,  4 Sep 2019 06:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567578034;
        bh=tD/HhnZjMDwOggSgTBR2yklwYyvJy/plqEZsXDK1rMQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=nXPU7NSQiFRBlvy0zKeXY5dBdirfhyAeH1/M/tEVYt4v1XW3qamdEMUvXBEZpwUNe
         o6Z5mhAkZhMrNx5AMbL2FOGnQEPs6MbSJO41uj9iT+jy9noNtQzwCa4uNlVXv58j49
         WITQdQ6td8PCqRfLCvchxv6QtlXxSFO7ITaDJPlw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7AFCE61577
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] ath9k: dyanck: introduce ath_dynack_set_timeout
 routine
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <4d64a2f91fcb8dbadaad8fef2e693abde47e6b5c.1566317488.git.lorenzo@kernel.org>
References: <4d64a2f91fcb8dbadaad8fef2e693abde47e6b5c.1566317488.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        koen.vandeputte@ncentric.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190904062044.83A9D615B0@smtp.codeaurora.org>
Date:   Wed,  4 Sep 2019 06:20:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Introduce ath_dynack_set_timeout routine to configure slottime/ack/cts
> timeouts and remove duplicated code
> 
> Tested-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

5df65dd52dd5 ath9k: dyanck: introduce ath_dynack_set_timeout routine
6999e40d5f1d ath9k: dynack: properly set last timeout timestamp in ath_dynack_reset
86e392994dee ath9k: dynack: set max timeout according to channel width
72bb1aa91ff8 ath9k: dynack: set ackto to max timeout in ath_dynack_reset

-- 
https://patchwork.kernel.org/patch/11104373/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

