Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8371286B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfECHE4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 03:04:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfECHEz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 03:04:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2E5EC61156; Fri,  3 May 2019 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556867095;
        bh=OyT8qsuh8ibPPnij7/0rJBaEnM9dbXjyfonsLWubQWg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RqsholnhGpeT3aC3TRCm3xK0rEj9JNfxAsMacr4mGjm9JxYAqIVvm+rqqs4tvj6US
         cw6F0plbgVCiVQfRhoWsko+2LRYCJ7Su03nRi1Db4BNDA38XSYmrCTCaKkA3d7XHvz
         a9m9jnGXediQuQ4sh4RCQ/QwNkjHjZX+1MzZjIh8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99F0760E42;
        Fri,  3 May 2019 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556867094;
        bh=OyT8qsuh8ibPPnij7/0rJBaEnM9dbXjyfonsLWubQWg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fxWw0YC0LBk+oljcfoDPemA1xdYJVgpDKTwO+ameFKirw8jTOYcgyYdk+gxLkYnqh
         xPHhP/rpfe49tttZcVJVcB/JTmbKoPiSlKEGCFO9sNVwV94vAd00Wd4Hok3CtyNEZP
         aH0WvWgDJsp5IkzgXplYlcCJFQL/o/UaP/EDFYuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99F0760E42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] ath10k: Fix rate table updation in tx stats
References: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
        <20190503060032.23F1C61195@smtp.codeaurora.org>
        <edfbff30627849996b0597b964ed018c@codeaurora.org>
Date:   Fri, 03 May 2019 10:04:50 +0300
In-Reply-To: <edfbff30627849996b0597b964ed018c@codeaurora.org> (Rakesh
        Pillai's message of "Fri, 03 May 2019 12:26:31 +0530")
Message-ID: <87d0l0koh9.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(please don't top post, fixing that manually)

Rakesh Pillai <pillair@codeaurora.org> writes:

> On 2019-05-03 11:30, Kalle Valo wrote:
>> Rakesh Pillai <pillair@codeaurora.org> wrote:
>>
>>> The index for updating rate table, which is displayed
>>> in the tx stats via debugfs, is calculated using the
>>> bandwidth value. The bandwidth values do not map
>>> correctly with the bandwidth values shown in the rate table.
>>>
>>> Correct the bandwidth value calculation which is used
>>> to calculate the index for rate table updation for tx stats.
>>>
>>> Tested HW: WCN3990
>>> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
>>>
>>> Fixes: e88975ca37d1 ("ath10k: dump tx stats in rate table format")
>>> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
>>
>> Fails to compile:
>>
>> drivers/net/wireless/ath/ath10k/htt_rx.c: In function
>> 'ath10k_accumulate_per_peer_tx_stats':
>> drivers/net/wireless/ath/ath10k/htt_rx.c:3252:14: error: implicit
>> declaration of function 'ath10k_get_bw'; did you mean
>> 'ath10k_get_tid'? [-Werror=implicit-function-declaration]
>>   rtable_bw = ath10k_get_bw(&ar->hw_params, pstats->flags);
>>               ^~~~~~~~~~~~~
>>               ath10k_get_tid
>
> This set of patches is dependent on
> https://patchwork.kernel.org/patch/10831319/
> I can send out v2 for this patchset, marking the dependency, if needed.

Ok, I added this patchset back to my queue. No need to resend.

-- 
Kalle Valo
