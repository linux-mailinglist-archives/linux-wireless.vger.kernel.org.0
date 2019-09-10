Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90773AEB59
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfIJNVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 09:21:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfIJNVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 09:21:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E592B60779; Tue, 10 Sep 2019 13:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121697;
        bh=AaO0IDEUweLPqWI1dylbnYPhwE2avgdcIi8aYKFtP0I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Y+jG9l6/yeXYhtBVg+IXvqi0dPQakCWxy7NTgHk76NocXBg9b9wJTvCkTIlZ952T9
         N9cxXerHfmkcZdtZ8hI38AMrYEwlq6s+X5g7osjTWbDOWbwBVLlr5Fttu5FNv7mptH
         1GBTw5sVmnBjJ6l7xnmdF82LpIc/mpUgirmToiJE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 425C7602F2;
        Tue, 10 Sep 2019 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121695;
        bh=AaO0IDEUweLPqWI1dylbnYPhwE2avgdcIi8aYKFtP0I=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=YbqopqSEVTpocHdjJPgutEI7di+tj6lLC4x0Hx48TlamkniuYl0n6fVsoyx5MLceA
         VBPZbqyFlISAGXxfOhUfrZX+iV3nUQyBrjPEw06box4OZYg0HSTC1CTB6tDnxNDdK7
         uN/vhOpWcgdBfSJIVAopJ9bQmGoq6/Si61WCgKAQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 425C7602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: add reorder and change PN check logic for mac80211
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1566368605-20109-1-git-send-email-wgong@codeaurora.org>
References: <1566368605-20109-1-git-send-email-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190910132137.E592B60779@smtp.codeaurora.org>
Date:   Tue, 10 Sep 2019 13:21:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> For sdio chip, if the rssi is not good, then it have some retry,
> firmware will indicate the msdu list of a ppdu with a hole, it
> means it lost the hole msdu, after the msdu retry from AP, the
> hole msdu will indicate from firmware later. The hole msdu's PN
> check will fail and the hole msdu will be dropped.
> 
> PN check fail example:
> Sequence number PN number  PN check status
>      3814         6101         success
>      3815         6102         success
>      3816         6103         success
>      3818         6105         success
>      3819         6106         success
>      3820         6107         success
>      3817         6104         fail
> 
> The correct logic is reorder the msdu list and then do PN check.
> ieee80211_rx_reorder_ampdu of mac80211 will do the reorer logic
> and then do PN check in ieee80211_rx_h_decrypt of mac80211.
> 
> example after reorder:
> Sequence number PN number  PN check status
>      3814         6101         success
>      3815         6102         success
>      3816         6103         success
>      3817         6104         success
>      3818         6105         success
>      3819         6106         success
>      3820         6107         success
> 
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

db8deae03271 ath10k: add reorder and change PN check logic for mac80211

-- 
https://patchwork.kernel.org/patch/11105545/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

