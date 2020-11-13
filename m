Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B32D2B142A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 03:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgKMCI2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 21:08:28 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:35708 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgKMCI1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 21:08:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605233307; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=pMrxmvN+z8kbW1ySQ1z021HcHfXaEdz1J1oQVNeXBh4=;
 b=kB6x1T6bYe5b/jwDf+QHvfrIAIIeE9YiZ4E9tpfgXhNYomsiS9hSQSE/pj2EOCeMFVugEOck
 RcxIItWkaWqYZ+FVbaYJntx3f0byKa4CG9L5WZ1z1HXl8LKwZ2nqwEB5g5EFV5PH3bI+bN39
 RfdtNCvugNWfsBw2j5cqp22E04o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fadea8e3825e013b5480291 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 02:08:14
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B98AC433FF; Fri, 13 Nov 2020 02:08:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41FF2C433C8;
        Fri, 13 Nov 2020 02:08:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Nov 2020 10:08:13 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, kirtika@google.com,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless-owner@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH v2] mac80211: reject/clear user rate mask if not usable
In-Reply-To: <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
References: <20170308132022.4216-1-johannes@sipsolutions.net>
 <07179008e9369bc81e152009ca85191d@codeaurora.org>
 <5decc452-7b2a-db1d-c5eb-04ab6bb61553@broadcom.com>
Message-ID: <4b8f37fde23262547edb6ed4635cf89b@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-12 20:49, Arend Van Spriel wrote:
> On 11/12/2020 11:55 AM, Wen Gong wrote:
>> On 2017-03-08 21:20, Johannes Berg wrote:
>>> From: Johannes Berg <johannes.berg@intel.com>
>>> 
> 
> [...]
> 
>>> @@ -2685,6 +2686,21 @@ static int ieee80211_set_bitrate_mask(struct
>>> wiphy *wiphy,
>>>              return ret;
>>>      }
>>> 
>>> +    /*
>>> +     * If active validate the setting and reject it if it doesn't 
>>> leave
>>> +     * at least one basic rate usable, since we really have to be 
>>> able
>>> +     * to send something, and if we're an AP we have to be able to 
>>> do
>>> +     * so at a basic rate so that all clients can receive it.
>>> +     */
>>> +    if (rcu_access_pointer(sdata->vif.chanctx_conf) &&
>>> +        sdata->vif.bss_conf.chandef.chan) {
>>> +        u32 basic_rates = sdata->vif.bss_conf.basic_rates;
>>> +        enum nl80211_band band = 
>>> sdata->vif.bss_conf.chandef.chan->band;
>>> +
>>> +        if (!(mask->control[band].legacy & basic_rates))
>>> +            return -EINVAL;
>> If user want to use “iw wlan0 set bitrates legacy-5 54” to set it to 
>> fixed in 54M and 54M is
>> not basic rate in AP's becaon as example of below, then the iw command 
>> will fail.
> 
> Which was the intent of this change, wasn't it? You want to allow
> anyway or you want a clear error message as to why it fails?
We need to set the tx rate to fixed at a single rate, e.g., 
54M/48M/36M... for a test case.
I do not want a clear error message, I want to the 54M rate pass/set 
success to lower wlan driver.
Then lower wlan driver can handle it.
> 
> Regards,
> Arend
