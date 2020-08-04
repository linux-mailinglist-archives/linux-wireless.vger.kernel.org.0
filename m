Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B455E23B3BB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Aug 2020 06:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHDEHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Aug 2020 00:07:40 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23708 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDEHj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Aug 2020 00:07:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596514058; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=SGwja8y8+2eEY7F6f9AFgaaHNgcS4XPsfiTS3Uu5iSY=; b=hRh05S8Xlb7+7gXqFRJL2JCZ8Kn4Fgaqz3Bsjnh8pYeN0BmgFm6+YBnXrVMbE1nbS1CIx3V5
 ykMX9m469eseG0LjCWldATxM+qzdeqCdtynt8qxx5OrlTj4Q4DVpK2/kG/JiqfyGMizkH19m
 s81etNIUXd7w3OUytM7lBv9I3dY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f28defdbcdc2fe471c93296 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 04:07:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D414C433C9; Tue,  4 Aug 2020 04:07:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D32EC433C6;
        Tue,  4 Aug 2020 04:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D32EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-drivers-next-2020-08-02
References: <20200802190136.CB524C433CA@smtp.codeaurora.org>
        <20200803.161852.1328879920773355611.davem@davemloft.net>
Date:   Tue, 04 Aug 2020 07:07:20 +0300
In-Reply-To: <20200803.161852.1328879920773355611.davem@davemloft.net> (David
        Miller's message of "Mon, 03 Aug 2020 16:18:52 -0700 (PDT)")
Message-ID: <87r1sncavb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Kalle Valo <kvalo@codeaurora.org>
> Date: Sun,  2 Aug 2020 19:01:36 +0000 (UTC)
>
>> here's a pull request to net-next tree, more info below. Please let me know if
>> there are any problems.
>
> There are many several non-trivial mt76 conflicts, can you please sort
> this out and send me another pull request?

Yeah, I noticed the same and I tried to explain how to fix those in the
signed tag:

----------------------------------------------------------------------
This pull request causes conflicts in four files in
drivers/net/wireless/mediatek/mt76/mt7615/, here is how I fixed those:

* usb.c: take the hunk which uses mt7663_usb_sdio_tx_*() functions

* mt7615.h: remove either one of the duplicate (and identical) enum tx_pkt_queue_idx

* mt7615.h: take the hunk which has mt7615_mutex_acquire/release() functions

* main.c: take the hunk which uses mt7615_mutex_acquire/release()

* mac.c: take the hunk which uses is_mmio
----------------------------------------------------------------------

By following those instructions it shouldn't take more than few minutes
to fix the conflicts.

Or would you prefer that I fix those differently, for example by pulling
net-next to wireless-drivers-next before I send the pull request? Just
let me know what you prefer.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
