Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5855612835
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 08:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfECG4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 02:56:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECG4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 02:56:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4651861196; Fri,  3 May 2019 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556866592;
        bh=CKHYLK4DMOav1+dBN3bvyTVHIGXKptSbPxL7DAcePzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y3x+RF2CrIkrTqH4OK3peMC46gbx738q1D2rRA8IgydlI14YBhL6E8imPck2M3pHi
         0YFVw42aMovTJY/0uO0Az8C+FpfgC29Qz2kYF5lMTMedsZvd0g9W5dVXmkuOV6fXEI
         4HcLUQ6H5ZgYH8BAJg9UOqSYnwtlrkXbQftLNY58=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id A836C60A42;
        Fri,  3 May 2019 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556866591;
        bh=CKHYLK4DMOav1+dBN3bvyTVHIGXKptSbPxL7DAcePzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xacl/NGWlsu3lN4nf1razueereOTFaSruNhtKUKQzv5g4jW+Y00Ed4kjNvQcg6PsH
         DB2PELOW96ZqoXoIobU56ZH+sXINMCkfru6DUlUVizk5ihD55uN3mxf6wYG//w7xn2
         vBUIORBsCkO5ePnNsxHYI0QFDAqayv8JziD8Rw0k=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 May 2019 12:26:31 +0530
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] ath10k: Fix rate table updation in tx stats
In-Reply-To: <20190503060032.23F1C61195@smtp.codeaurora.org>
References: <1552319602-17795-2-git-send-email-pillair@codeaurora.org>
 <20190503060032.23F1C61195@smtp.codeaurora.org>
Message-ID: <edfbff30627849996b0597b964ed018c@codeaurora.org>
X-Sender: pillair@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

This set of patches is dependent on 
https://patchwork.kernel.org/patch/10831319/
I can send out v2 for this patchset, marking the dependency, if needed.

Thanks,
Rakesh Pillai.


On 2019-05-03 11:30, Kalle Valo wrote:
> Rakesh Pillai <pillair@codeaurora.org> wrote:
> 
>> The index for updating rate table, which is displayed
>> in the tx stats via debugfs, is calculated using the
>> bandwidth value. The bandwidth values do not map
>> correctly with the bandwidth values shown in the rate table.
>> 
>> Correct the bandwidth value calculation which is used
>> to calculate the index for rate table updation for tx stats.
>> 
>> Tested HW: WCN3990
>> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
>> 
>> Fixes: e88975ca37d1 ("ath10k: dump tx stats in rate table format")
>> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> 
> Fails to compile:
> 
> drivers/net/wireless/ath/ath10k/htt_rx.c: In function
> 'ath10k_accumulate_per_peer_tx_stats':
> drivers/net/wireless/ath/ath10k/htt_rx.c:3252:14: error: implicit
> declaration of function 'ath10k_get_bw'; did you mean
> 'ath10k_get_tid'? [-Werror=implicit-function-declaration]
>   rtable_bw = ath10k_get_bw(&ar->hw_params, pstats->flags);
>               ^~~~~~~~~~~~~
>               ath10k_get_tid
> cc1: some warnings being treated as errors
> make[5]: *** [drivers/net/wireless/ath/ath10k/htt_rx.o] Error 1
> make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
> make[3]: *** [drivers/net/wireless/ath] Error 2
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [drivers] Error 2
> 
> 2 patches set to Changes Requested.
> 
> 10847733 [1/2] ath10k: Fix rate table updation in tx stats
> 10847737 [2/2] ath10k: Fix NSS tx stats for legacy rates
