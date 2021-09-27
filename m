Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A58418E21
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhI0EVm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 00:21:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39054 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhI0EVm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 00:21:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632716405; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Hg92022NZ2LLcfTeTol26mPSdM56Bzl5myW+9iN1OhA=;
 b=Uk47YJyoz51my+dRScLXv7WWl+0ufy/Obv4BolR+VyZlVb5NjbZmkZWnYh3W4NDpJc39DtJB
 jgXcimNppjL3eDtgQirGfNvAHlmGoUw+AzvnEFfbdrFQk4gMYtwPBaNPl1R3YGJYjwQbEwwL
 0qHMUmTOUhcsaMbyJOMCILZAvD0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 615146625f16bce668eb1377 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 04:19:46
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB9A2C4360D; Mon, 27 Sep 2021 04:19:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 540A5C4338F;
        Mon, 27 Sep 2021 04:19:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Sep 2021 09:49:45 +0530
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: add htt cmd to enable full monitor mode
In-Reply-To: <87tuiaryhk.fsf@codeaurora.org>
References: <20210721171905.61838-1-jouni@codeaurora.org>
 <20210721171905.61838-2-jouni@codeaurora.org>
 <87tuiaryhk.fsf@codeaurora.org>
Message-ID: <f01c7797e7072687ab6014ccba431eb9@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-24 17:12, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Anilkumar Kolli <akolli@codeaurora.org>
>> 
>> Add a new hw_param full_monitor_mode to enable full monitor support 
>> for
>> QCN9074. HTT_H2T_MSG_TYPE_RX_FULL_MONITOR_MODE cmd is sent to the
>> firmware to enable the full monitor mode.
> 
> Nowhere it's explained what "full monitor mode" means from an user's
> point of view. Can someone give a high level summary what advantages
> this feature has? For example, more frames delivered to user space or
> what?

Yes, more frames delivered with full monitor mode. The advantage with 
full
monitor mode is, hardware has status buffers available for all the MPDUs 
in
mon_dst_ring. Both status buffer and MPDUs from mon_dst_ring is used to 
build
the frame.

Patch "ath11k: Process full monitor mode rx support" has the commit 
message.

In full monitor mode, monitor destination ring is read before monitor
status ring. mon_dst_ring has ppdu id, reap till the end of PPDU. Add
all the MPDUs to list. Start processing the status ring, if PPDU id in
status ring is lagging behind, reap the status ring, once the PPDU ID
matches, deliver the MSDU to upper layer. If status PPDU id leading,
reap the mon_dst_ring. The advantage with full monitor mode is hardware
has status buffers available for all the MPDUs in mon_dst_ring.

- Anil.
