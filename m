Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164CC12766
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfECGAd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 02:00:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfECGAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 02:00:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5AC5C61197; Fri,  3 May 2019 06:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556863232;
        bh=5VofvhO3q6xFvNAjHarBuvHnfU1B5Z8su4odSZgCzQk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j+5jnP6tA7OEiNGWO5O+crlBaoPJLAlEwqv7KLEg081lfTXSMg9J8Uhosm04VO4kh
         I/JYaiHm5HF5rpAOKPOMlUK3oRqS6gEKR5Qzx5AWcUmIVZahgNOmqspy09d+TnUDI6
         oYGEbVEoxKFUmZvEaZCIp1s7ilYkUJ04fkrgvHF4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7F7C6115B;
        Fri,  3 May 2019 06:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556863231;
        bh=5VofvhO3q6xFvNAjHarBuvHnfU1B5Z8su4odSZgCzQk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=dZdvsSx8q8Z9xvd7BD7ViC48wvdYq2pcEEjZ/EyJ/FfJI+hQltx7mWOHn/NwK/Itz
         GakUy4s2sgt4ZdmxXqZdzwkb6linUz4mVjRj8KItesI3uskh3LGBRVnxxerT3vc0Sn
         R+qO8B44wI4BevELN19El+SYZRWEgCLHk6uqJa8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7F7C6115B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: Fix rate table updation in tx stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
References: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190503060032.5AC5C61197@smtp.codeaurora.org>
Date:   Fri,  3 May 2019 06:00:32 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> wrote:

> The index for updating rate table, which is displayed
> in the tx stats via debugfs, is calculated using the
> bandwidth value. The bandwidth values do not map
> correctly with the bandwidth values shown in the rate table.
> 
> Correct the bandwidth value calculation which is used
> to calculate the index for rate table updation for tx stats.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Fixes: e88975ca37d1 ("ath10k: dump tx stats in rate table format")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

Fails to compile:

drivers/net/wireless/ath/ath10k/htt_rx.c: In function 'ath10k_accumulate_per_peer_tx_stats':
drivers/net/wireless/ath/ath10k/htt_rx.c:3252:14: error: implicit declaration of function 'ath10k_get_bw'; did you mean 'ath10k_get_tid'? [-Werror=implicit-function-declaration]
  rtable_bw = ath10k_get_bw(&ar->hw_params, pstats->flags);
              ^~~~~~~~~~~~~
              ath10k_get_tid
cc1: some warnings being treated as errors
make[5]: *** [drivers/net/wireless/ath/ath10k/htt_rx.o] Error 1
make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
make[3]: *** [drivers/net/wireless/ath] Error 2
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [drivers] Error 2

2 patches set to Changes Requested.

10847733 [1/2] ath10k: Fix rate table updation in tx stats
10847737 [2/2] ath10k: Fix NSS tx stats for legacy rates

-- 
https://patchwork.kernel.org/patch/10847733/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

