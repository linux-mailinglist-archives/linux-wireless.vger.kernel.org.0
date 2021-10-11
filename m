Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3E4289A6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 11:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhJKJa2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 05:30:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61485 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235499AbhJKJa1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 05:30:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633944508; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=I+oj08hUi2aiHJx4O0L6ZY2tkEVr7etvPvmp7zVbPOM=; b=QxQkmsRGIl68ZaEDb/2XtcfwRoKdOPxhh3pjwhfieq34jPTghN6wgFsA19e21/ypbEyHtUpp
 UBpgQMf6drm5zd50f5eoOr9J6XLcEtXbabWVNy3gqtauRhMEhxkHniMSJY+/+h4YG5NE0F5W
 hl7brBSTTxmgpaeegCD72Y0TLo8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 616403afab9da96e64e06408 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 09:28:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AD3DBC43460; Mon, 11 Oct 2021 09:28:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9069AC4338F;
        Mon, 11 Oct 2021 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9069AC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ben Greear <greearb@candelatech.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 05/11] mt76: mt7915: debugfs hook to enable TXS for NO_SKB pkt-ids
References: <20210804134505.3208-1-greearb@candelatech.com>
        <20210804134505.3208-5-greearb@candelatech.com>
        <87mtpda079.fsf@tynnyri.adurom.net>
        <093b94ea-b6db-aca8-26c4-6981e57e8ff4@candelatech.com>
Date:   Mon, 11 Oct 2021 12:28:11 +0300
In-Reply-To: <093b94ea-b6db-aca8-26c4-6981e57e8ff4@candelatech.com> (Ben
        Greear's message of "Thu, 19 Aug 2021 09:08:50 -0700")
Message-ID: <87ily352s4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> On 8/19/21 9:06 AM, Kalle Valo wrote:
>> greearb@candelatech.com writes:
>>
>>> From: Ben Greear <greearb@candelatech.com>
>>>
>>> This lets user turn on/off this feature.  Enabling gives better
>>> tx-rate related stats, but will cause extra driver and (maybe)
>>> firmware work.  Not sure if it actually affects performance or
>>> not.
>>>
>>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>>
>> This is grey area, debugfs is not really meant to be used for users
>> enabling driver features.
>>
>
> What method do you suggest?  Surely not trying to drive something down through
> netlink for something this chipset specific?

I think a module parameter would be a good choise for enabling this kind
of feature.

Of course the downside of a module parater is that when it's not
possible to configure this per device, only per driver. Like discussed
many times in the past, we would really need some kind more advanced
module parameters which can be per device.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
