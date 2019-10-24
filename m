Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1318CE2DB5
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2019 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390775AbfJXJk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Oct 2019 05:40:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfJXJk2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Oct 2019 05:40:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 878A061069; Thu, 24 Oct 2019 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910027;
        bh=RpzuRCtxTdpM4TGsOHhiUmecfsb9FisvPIpB9QSVE7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IUSCoPlfTKRm3mqrUXs0r0dkJuoMehYvPtJIDNv0AoNxM4xuRC8z+lZ8/ECcZs2wn
         fB2rAma8LIROH35VK1gb4o4S8FtDCP/YaGAmrMhmDdqYT3qQeE9kU5Qn0qclhKAw1M
         5cfh399V9o7b/VcHLy96GiJ+LhG89ys7CNKhBhW0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 068CD6135A;
        Thu, 24 Oct 2019 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571910026;
        bh=RpzuRCtxTdpM4TGsOHhiUmecfsb9FisvPIpB9QSVE7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EO3iRyBJhIHdc5BGNEaeEcAAESxwhomaOc6oQbg3Vl7M3FYHT8robYoL3dd4ymdjE
         O/THd85vxj2C6utsg3rX5ZnyTehRINtZiMIjT4Ob3yvTRHqOWmJmbs1A5LBe/2la1s
         TdH9XUBvvFHh5ImRfBd6+tiqbaOGzv7G2J5aYsc4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 17:40:25 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ath10k: change max RX bundle size from 8 to 32 for
 sdio
In-Reply-To: <87r232sdeh.fsf@kamboji.qca.qualcomm.com>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-3-git-send-email-wgong@codeaurora.org>
 <87r232sdeh.fsf@kamboji.qca.qualcomm.com>
Message-ID: <c2227ffd5901b03a2874fddb98298e0d@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-10-24 17:25, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> The max bundle size support by firmware is 32, change it from 8 to 32
>> will help performance. This results in significant performance
>> improvement on RX path.
>> 
>> Tested with QCA6174 SDIO with firmware
>> WLAN.RMH.4.4.1-00017-QCARMSWPZ-1
>> 
>> Signed-off-by: Wen Gong <wgong@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath10k/htc.h  | 12 +++++++++---
>>  drivers/net/wireless/ath/ath10k/sdio.c |  4 ++--
>>  drivers/net/wireless/ath/ath10k/sdio.h |  4 ++--
>>  3 files changed, 13 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath10k/htc.h 
>> b/drivers/net/wireless/ath/ath10k/htc.h
>> index f55d3ca..7055156 100644
>> --- a/drivers/net/wireless/ath/ath10k/htc.h
>> +++ b/drivers/net/wireless/ath/ath10k/htc.h
>> @@ -39,7 +39,7 @@
>>   * 4-byte aligned.
>>   */
>> 
>> -#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        8
>> +#define HTC_HOST_MAX_MSG_PER_RX_BUNDLE        32
> 
> So how do I know that this change doesn't break any other hardware? I
> did a quick review and I think it's safe, but the commit log mentions
> nothing about this.
the real max rx bundle is decided in ath10k_htc_wait_target.
it is the min value of HTC_HOST_MAX_MSG_PER_RX_BUNDLE and the value 
reported from firmware.
htc->max_msgs_per_htc_bundle =
			min_t(u8, msg->ready_ext.max_msgs_per_htc_bundle,
			      HTC_HOST_MAX_MSG_PER_RX_BUNDLE);
> 
> Please clarify and I can update the commit log.
