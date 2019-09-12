Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9CB1405
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfILRvh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 13:51:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfILRvh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 13:51:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3D2F96083E; Thu, 12 Sep 2019 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568310696;
        bh=kXsMDOtWTcNbxd196a6efQcC5znV1ESekIYUH1AgZ4g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WbZSZf4yDTiH7qE3M5gI+8i1nZ28OtxHMdfVLWoGslECknQAI4xtDJVPcopkNr6rc
         da0dfkxuOWrPVCKI0pSiWqxro6WzgfwfAA+Ade7pg55kG7csDsI1wGD3Ze+YF0bZGO
         DKAUtpvouW6DUInvqMC7ypw/UtbRcV6nhYCe/dY4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C39E60790;
        Thu, 12 Sep 2019 17:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568310695;
        bh=kXsMDOtWTcNbxd196a6efQcC5znV1ESekIYUH1AgZ4g=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=N9e0lRkVSBtnvypTmYuf3flKusG3XHvYMVCGh3rDppoyOTOYWtIsVfiYyR946XxHl
         e1QU1JNodRgMD5deA6aNP6loAF7xXcn4T6uE1ialLcuk9HzuHBQeBegKbr624ePDWq
         I/Pfg10TGihvqAx95/0BAw+dFPygRXXiPXMoWbq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C39E60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v5 0/8] ath10k: improve throughout of tcp/udp TX/RX of sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <87tv9hikwe.fsf@kamboji.qca.qualcomm.com>
Date:   Thu, 12 Sep 2019 20:51:32 +0300
In-Reply-To: <87tv9hikwe.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Thu, 12 Sep 2019 18:39:29 +0300")
Message-ID: <87d0g5h07v.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Wen Gong <wgong@codeaurora.org> writes:
>
>> The bottleneck of throughout on sdio chip is the bus bandwidth, to the
>> patches are all to increase the use ratio of sdio bus.
>>
>>                       udp-rx    udp-tx    tcp-rx    tcp-tx
>> without patches(Mbps)  320        180       170       151
>> with patches(Mbps)     450        410       400       320
>>
>> These patches only affect sdio bus chip, explanation is mentioned in each
>> patch's commit log.
>
> I tried to apply patches 2-8, patch 2 had a conflict due to my changes
> and patch 8 didn't apply at all. Also I saw few warnings with the
> patches I was able to test:
>
> $ ath10k-check
> drivers/net/wireless/ath/ath10k/htc.c: In function 'ath10k_htc_bundle_tx_work':
> drivers/net/wireless/ath/ath10k/htc.c:796:24: warning: variable 'eid'
> set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/ath/ath10k/sdio.c:2169:6: warning: no previous
> prototype for 'ath10k_sdio_check_fw_reg' [-Wmissing-prototypes]
> drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_check_fw_reg':
> drivers/net/wireless/ath/ath10k/sdio.c:2171:6: warning: variable 'ret'
> set but not used [-Wunused-but-set-variable]
> drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_fw_crashed_dump':
> drivers/net/wireless/ath/ath10k/sdio.c:2434:17: warning: too many
> arguments for format [-Wformat-extra-args]
> drivers/net/wireless/ath/ath10k/sdio.c:2169:6: warning: symbol
> 'ath10k_sdio_check_fw_reg' was not declared. Should it be static?
> drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_fw_crashed_dump':
> drivers/net/wireless/ath/ath10k/sdio.c:2434:17: warning: too many
> arguments for format [-Wformat-extra-args]
> drivers/net/wireless/ath/ath10k/sdio.c:734: braces {} are not
> necessary for single statement blocks
> drivers/net/wireless/ath/ath10k/sdio.c:969: braces {} are not
> necessary for single statement blocks

Actually some of the warnings are from another patch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
