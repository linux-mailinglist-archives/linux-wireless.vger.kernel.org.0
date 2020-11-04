Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B392A5EC6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 08:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKDHcb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 02:32:31 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:27101 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgKDHca (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 02:32:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604475150; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PmT/lRSSkZac1ZkiO1gAPjcZE46NX2dF9QNKGHEK6Hk=;
 b=bqfcJBYU+/eQxQ4c8PNL4u21BZBdDJrhGixSb+dO9v2Kg7tM+u7yiZLOJqx5WGdMtP2hM9BM
 qJCl8R33/BxhN/1BMcjZXd9RZOshO7nUSjO1g+w4GsiS8s2KaKljb+hCGsdqKWj2eQCvLQt1
 O8IEuZ7IxBkjAC6rONJq8yDmzV0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fa2590750440018cb3cf92b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 07:32:23
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53A55C433C9; Wed,  4 Nov 2020 07:32:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0029C433C6;
        Wed,  4 Nov 2020 07:32:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Nov 2020 15:32:21 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        ath11k@lists.infradead.org, Doug Anderson <dianders@chromium.org>
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
References: <1600753017-4614-1-git-send-email-cjhuang@codeaurora.org>
 <CA+ASDXM7TcF-zfbktbdSu-fDBuGe0LAgFq3Qt2zaq6efbWJ=sA@mail.gmail.com>
Message-ID: <f3be456c4c748f21836279eb4dc16e5e@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-04 10:00, Brian Norris wrote:
> On Mon, Sep 21, 2020 at 10:37 PM Carl Huang <cjhuang@codeaurora.org> 
> wrote:
>> +/**
>> + * struct cfg80211_sar_capa - sar limit capability
>> + * @type: it's set via power in 0.25dbm or other types
>> + * @num_freq_ranges: number of frequency ranges
>> + * @chan_ranges: memory to hold the channel ranges.
>> + */
>> +struct cfg80211_sar_capa {
>> +       enum nl80211_sar_type type;
>> +       u8 num_freq_ranges;
>> +       const struct cfg80211_sar_freq_ranges *freq_ranges;
>> +};
> ...
>>         u8 max_data_retry_count;
>> 
>> +       const struct cfg80211_sar_capa *sar_capa;
>> +
>>         char priv[] __aligned(NETDEV_ALIGN);
>>  };
> 
> What are the ABI guarantees around a given driver/chip's 'sar_capa'?
> Do we guarantee that if the driver supports N ranges of certain bands,
> that it will always continue to support those bands? What if, for
> instance, ath10k grows a new set of subbands, supporting sub-sections
> of the 5GHz band -- does it still need to support both a contiguous
> [5, 5 + X] and a split [5, 5 + X/2], [5 + X/2, 5 + X]? Basically, do
> we intend to put the burden on user space to figure out how to map its
> power tables to the supported frequency band(s), or on the kernel, to
> support a backwards-compatible set of frequency ranges? The latter
> doesn't really work if you expect user space to always specify all
> ranges in a SET command.
> 
> To be clear, I'm not as worried about differences between chips or
> drivers (I expect that different driver or chips may have different
> range support); just about stability for a given chip.
> 
For a given chip(at least a QCOM chip), we don't see that the
range will grow or change.

In addition, with current index-power SET method, it's hard for driver
to know what the index mean given your example. Does the index mean
[5,5 + x] or [5, 5 + x/2] ?  So it's required for user-space to specify
all the ranges.

The number of ranges is quite small, so the SET itself is not a
problem to specify all.

Brian, are you fine that we go with this proposal? I'll send
V2 based on the comments from Johannes and Abhishek.


> Brian
