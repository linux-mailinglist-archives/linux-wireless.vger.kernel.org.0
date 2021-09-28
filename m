Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEEF41A923
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhI1G6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 02:58:18 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:26574 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239043AbhI1G6R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 02:58:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632812199; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=iSoNn9rVBBCwIwnakNyJsEuzM1QdDkG7wWg95OqmLuo=; b=Vrdp142m4y+jKMLdChqo8d9t2VC1qWDXnFRbQ8lTr/M7fhTyw6WcYiTEvvmHYqrd10Rk2q6c
 sn2tcFaKSGIqn1fpM2ON37iDpBU2p0FctHFuf33r8wY+idQNlCA4vsE7qa2LM4aRmTY+Cx7N
 MTY0kSgCIQJp7HgW0mLc96DSmvU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6152bc969ffb4131494eaf79 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 06:56:22
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7D431C4360C; Tue, 28 Sep 2021 06:56:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D567FC4338F;
        Tue, 28 Sep 2021 06:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D567FC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     akolli@codeaurora.org
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
References: <20210721171905.61838-1-jouni@codeaurora.org>
        <20210721171905.61838-2-jouni@codeaurora.org>
        <87tuiaryhk.fsf@codeaurora.org>
        <f01c7797e7072687ab6014ccba431eb9@codeaurora.org>
Date:   Tue, 28 Sep 2021 09:56:13 +0300
In-Reply-To: <f01c7797e7072687ab6014ccba431eb9@codeaurora.org> (akolli's
        message of "Mon, 27 Sep 2021 09:49:45 +0530")
Message-ID: <87sfxpqjci.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

akolli@codeaurora.org writes:

> On 2021-09-24 17:12, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>
>>> From: Anilkumar Kolli <akolli@codeaurora.org>
>>>
>>> Add a new hw_param full_monitor_mode to enable full monitor support
>>> for
>>> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
>>> firmware to enable the full monitor mode.
>>
>> Nowhere it's explained what "full monitor mode" means from an user's
>> point of view. Can someone give a high level summary what advantages
>> this feature has? For example, more frames delivered to user space or
>> what?
>
> Yes, more frames delivered with full monitor mode. The advantage with
> full monitor mode is, hardware has status buffers available for all
> the MPDUs in mon_dst_ring. Both status buffer and MPDUs from
> mon_dst_ring is used to build the frame.

Users, and developers outside of the wireless domain, have no clue what
"MPDUs in mon_dst_ring" means, just as an example. Can you give a higher
level summary of this feature and what benefit it brings, please? I'll
then add that to the commit log.

For example, what kind of frames are we now able to deliver to the user
space (which we before couldn't) and are there still some types of
frames which we are not delivering?

In other words, instead of technical low level jargon I'm looking for a
summary in plain english which is understandable by everyone.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
