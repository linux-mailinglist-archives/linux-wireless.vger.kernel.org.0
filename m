Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D6420536
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Oct 2021 06:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhJDEZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Oct 2021 00:25:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44625 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhJDEZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Oct 2021 00:25:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633321403; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TgM8C0DI9hcG2ezxrSOzrJIHZklp8GdLdGqApBfSTaE=;
 b=t7KABxofwIZ9kXYZ2ppmpkOa6UaIC+fObecP2U17YIv8wcrI4N0JvK0wGzixcdDT7dnGLnIX
 319pHNfdqsfeJ35RAvV1O2XOMVOHP8WqsY76F2sG8NU4COaWFwCt9xnRvcrpa+X6J4q80SHy
 Z25iRxf+gELfEOhA4/WmBWuUoi4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 615a81b8713d5d6f9608ee0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Oct 2021 04:23:20
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 696B7C4360C; Mon,  4 Oct 2021 04:23:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05445C4338F;
        Mon,  4 Oct 2021 04:23:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Oct 2021 09:53:18 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        akolli=codeaurora.org@codeaurora.org
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
In-Reply-To: <190d91d77d24c708291111710d4667b0@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
 <20210721171905.61838-2-jouni@codeaurora.org>
 <87tuiaryhk.fsf@codeaurora.org>
 <f01c7797e7072687ab6014ccba431eb9@codeaurora.org>
 <87sfxpqjci.fsf@codeaurora.org>
 <190d91d77d24c708291111710d4667b0@codeaurora.org>
Message-ID: <88d088e700888eb9c97eb5c2984af65f@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-30 12:17, Anilkumar Kolli wrote:
> On 2021-09-28 12:26, Kalle Valo wrote:
>> akolli@codeaurora.org writes:
>> 
>>> On 2021-09-24 17:12, Kalle Valo wrote:
>>>> Jouni Malinen <jouni@codeaurora.org> writes:
>>>> 
>>>>> From: Anilkumar Kolli <akolli@codeaurora.org>
>>>>> 
>>>>> Add a new hw_param full_monitor_mode to enable full monitor support
>>>>> for
>>>>> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
>>>>> firmware to enable the full monitor mode.
>>>> 
>>>> Nowhere it's explained what "full monitor mode" means from an user's
>>>> point of view. Can someone give a high level summary what advantages
>>>> this feature has? For example, more frames delivered to user space 
>>>> or
>>>> what?
>>> 
>>> Yes, more frames delivered with full monitor mode. The advantage with
>>> full monitor mode is, hardware has status buffers available for all
>>> the MPDUs in mon_dst_ring. Both status buffer and MPDUs from
>>> mon_dst_ring is used to build the frame.
>> 
>> Users, and developers outside of the wireless domain, have no clue 
>> what
>> "MPDUs in mon_dst_ring" means, just as an example. Can you give a 
>> higher
>> level summary of this feature and what benefit it brings, please? I'll
>> then add that to the commit log.
>> 
>> For example, what kind of frames are we now able to deliver to the 
>> user
>> space (which we before couldn't) and are there still some types of
>> frames which we are not delivering?
>> 
>> In other words, instead of technical low level jargon I'm looking for 
>> a
>> summary in plain english which is understandable by everyone.
> 
> Full monitor mode is hardware enhancement for QCN9074. With this more
> frames are delivered to mac80211.
> 
> In earlier hardware like IPQ8074, on each interrupt, reap complete
> monitor status ring.
> For each PPDU_DONE status, reap monitor destination ring, this needs
> more processing on driver.
> 
> With full monitor, on Interrupt, there is no need to reap the complete
> monitor status ring.
> Instead only one PPDU is reap from monitor destination ring and
> corresponding PPDU status is reaped.
> 
> In older approach, in noisy environments status buffers are missing
> for few PPDU, even in that case
> Host reaps monitor destination ring, which is not needed and these
> frames are dropped.
> 

Radiotap header is constructed from monitor status buffer tlvs. Since 
there is
no update of status buffer for few PPDU, complete 80211 frame is not 
formed and
is dropped in ath11k.

> In full monitor mode, for all MPDUs in a PPDU, status is guaranteed,
> this is achieved in hardware using lock-stepping.
> So more frames delivered to mac80211 and more fames seen in sniffer. "
> 


- Anil.
