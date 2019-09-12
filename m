Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BE0B1258
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfILPje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 11:39:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732566AbfILPje (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 11:39:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7A2296083E; Thu, 12 Sep 2019 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568302773;
        bh=hHHBTfNtzMKKd0mSltPpqrfqv6HJp7GitBCPceSZ6mc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hWmU42krLoUvkLK313LJ7Kr63UCkwnN8A4BRMCk1xse4rwVH9jHE/4rRAafH9+ZQy
         xG5eTvVRFwE4S+ZTUoB49yG8samH64/WWj+Ahw7UmhQruGIAblv0MoKxnS9QYpxmH4
         nlcV+3LUlCuk4eCL9PRTj1VgEcsNJpWgwqbEYGrw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 848B16055A;
        Thu, 12 Sep 2019 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568302772;
        bh=hHHBTfNtzMKKd0mSltPpqrfqv6HJp7GitBCPceSZ6mc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cLPuYJokIj+wsdj6tpwXTxDf/adYZnXXIlKzHid088HzjM0do1p0Q/gkP7ASE36+r
         sYNihBu63AYsrrbr03+ro30377Ej6BvouZrAbcJ+IStiMAxVKRlKhNlOGU6oloVbK8
         +qUpdlIOLHrdkxyZfO5EyvZPbdHvwJogZr8AiP/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 848B16055A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
Date:   Thu, 12 Sep 2019 18:39:29 +0300
In-Reply-To: <1567679893-14029-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:05 +0800")
Message-ID: <87tv9hikwe.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The bottleneck of throughout on sdio chip is the bus bandwidth, to the
> patches are all to increase the use ratio of sdio bus.
>
>                       udp-rx    udp-tx    tcp-rx    tcp-tx
> without patches(Mbps)  320        180       170       151
> with patches(Mbps)     450        410       400       320
>
> These patches only affect sdio bus chip, explanation is mentioned in each
> patch's commit log.

I tried to apply patches 2-8, patch 2 had a conflict due to my changes
and patch 8 didn't apply at all. Also I saw few warnings with the
patches I was able to test:

$ ath10k-check
drivers/net/wireless/ath/ath10k/htc.c: In function 'ath10k_htc_bundle_tx_work':
drivers/net/wireless/ath/ath10k/htc.c:796:24: warning: variable 'eid' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath10k/sdio.c:2169:6: warning: no previous prototype for 'ath10k_sdio_check_fw_reg' [-Wmissing-prototypes]
drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_check_fw_reg':
drivers/net/wireless/ath/ath10k/sdio.c:2171:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_fw_crashed_dump':
drivers/net/wireless/ath/ath10k/sdio.c:2434:17: warning: too many arguments for format [-Wformat-extra-args]
drivers/net/wireless/ath/ath10k/sdio.c:2169:6: warning: symbol 'ath10k_sdio_check_fw_reg' was not declared. Should it be static?
drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_fw_crashed_dump':
drivers/net/wireless/ath/ath10k/sdio.c:2434:17: warning: too many arguments for format [-Wformat-extra-args]
drivers/net/wireless/ath/ath10k/sdio.c:734: braces {} are not necessary for single statement blocks
drivers/net/wireless/ath/ath10k/sdio.c:969: braces {} are not necessary for single statement blocks

But please don't send a new version until I have provided review
comments.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
