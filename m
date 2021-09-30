Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD241D394
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Sep 2021 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbhI3Gtg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Sep 2021 02:49:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50220 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348342AbhI3Gtg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Sep 2021 02:49:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632984473; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UdtFKohGY9GDd/sV+AtOBOv4obD/FjRb2InDBqRodek=;
 b=UK6P7MYUOPncHXarICa8kLqRin8yh3N8cHMRTxzOxKR0cooKK2xApipoGy+bhXv+7ep46ahv
 Dxr7fKr8OKimj2WcUdk3Byob5ax2YiKceHQulBuWGRQyIx4MIdjk8i7fLFLJsYZeRQQvXqGH
 qw3mVQ9pzzAv2FFX8opXf5z3AqI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61555d99a3e8d3c64047ff4c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Sep 2021 06:47:53
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B5943C4360C; Thu, 30 Sep 2021 06:47:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1316DC4338F;
        Thu, 30 Sep 2021 06:47:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Sep 2021 12:17:51 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
In-Reply-To: <87sfxpqjci.fsf@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
 <20210721171905.61838-2-jouni@codeaurora.org>
 <87tuiaryhk.fsf@codeaurora.org>
 <f01c7797e7072687ab6014ccba431eb9@codeaurora.org>
 <87sfxpqjci.fsf@codeaurora.org>
Message-ID: <190d91d77d24c708291111710d4667b0@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 12:26, Kalle Valo wrote:
> akolli@codeaurora.org writes:
> 
>> On 2021-09-24 17:12, Kalle Valo wrote:
>>> Jouni Malinen <jouni@codeaurora.org> writes:
>>> 
>>>> From: Anilkumar Kolli <akolli@codeaurora.org>
>>>> 
>>>> Add a new hw_param full_monitor_mode to enable full monitor support
>>>> for
>>>> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
>>>> firmware to enable the full monitor mode.
>>> 
>>> Nowhere it's explained what "full monitor mode" means from an user's
>>> point of view. Can someone give a high level summary what advantages
>>> this feature has? For example, more frames delivered to user space or
>>> what?
>> 
>> Yes, more frames delivered with full monitor mode. The advantage with
>> full monitor mode is, hardware has status buffers available for all
>> the MPDUs in mon_dst_ring. Both status buffer and MPDUs from
>> mon_dst_ring is used to build the frame.
> 
> Users, and developers outside of the wireless domain, have no clue what
> "MPDUs in mon_dst_ring" means, just as an example. Can you give a 
> higher
> level summary of this feature and what benefit it brings, please? I'll
> then add that to the commit log.
> 
> For example, what kind of frames are we now able to deliver to the user
> space (which we before couldn't) and are there still some types of
> frames which we are not delivering?
> 
> In other words, instead of technical low level jargon I'm looking for a
> summary in plain english which is understandable by everyone.

Full monitor mode is hardware enhancement for QCN9074. With this more 
frames are delivered to mac80211.

In earlier hardware like IPQ8074, on each interrupt, reap complete 
monitor status ring.
For each PPDU_DONE status, reap monitor destination ring, this needs 
more processing on driver.

With full monitor, on Interrupt, there is no need to reap the complete 
monitor status ring.
Instead only one PPDU is reap from monitor destination ring and 
corresponding PPDU status is reaped.

In older approach, in noisy environments status buffers are missing for 
few PPDU, even in that case
Host reaps monitor destination ring, which is not needed and these 
frames are dropped.

In full monitor mode, for all MPDUs in a PPDU, status is guaranteed, 
this is achieved in hardware using lock-stepping.
So more frames delivered to mac80211 and more fames seen in sniffer. "

- Anil.
