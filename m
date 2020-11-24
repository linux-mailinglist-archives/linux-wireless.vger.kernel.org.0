Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88252C1C6B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 05:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgKXD7R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 22:59:17 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19387 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbgKXD7R (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 22:59:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606190356; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hVVYFeHEMjVTO6EZh/1nkgVxjKKS2OCW+znHKHwKHH4=;
 b=f0xbojgUsnhQI8WD7DB30v8bLrdS3NeJPjB6e6VJcAEvOZ846SW0kE5omFRp72DinVSTpZRN
 u03eLJCStJklKJyeRtL5RNYVt/gMlYc94zq8qvuvi9l58kQWCj9AFTxZnUTCdFzZWGOdqu6a
 YHRc+eNS1NF1gnyz+NiEXhWnS6I=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5fbc85117e9d874dfc246baf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 03:59:13
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 989FBC43464; Tue, 24 Nov 2020 03:59:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23BC8C43462;
        Tue, 24 Nov 2020 03:59:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Nov 2020 11:59:13 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 14/17] mac80211: support S1G association
In-Reply-To: <0a87b577fe443b0d7979f30d24767c4b@adapt-ip.com>
References: <20200922022818.15855-1-thomas@adapt-ip.com>
 <20200922022818.15855-15-thomas@adapt-ip.com>
 <af51dd8e9dea2961546a502d9090d1a7@codeaurora.org>
 <0a87b577fe443b0d7979f30d24767c4b@adapt-ip.com>
Message-ID: <5d5df04df5a972d8be0c67c75298b82a@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-24 02:40, Thomas Pedersen wrote:
> On 2020-11-23 00:38, Wen Gong wrote:
>> On 2020-09-22 10:28, Thomas Pedersen wrote:
>> ...
>>> @@ -3446,6 +3453,42 @@ bool ieee80211_chandef_he_6ghz_oper(struct
>>> ieee80211_sub_if_data *sdata,
>>> 
>>>  	*chandef = he_chandef;
>>> 
>>> +	return false;
>>> +}
>> This change the "return true" to "return false" by default of
>> ieee80211_chandef_he_6ghz_oper.
>> It should be typo mistake.
> 
> Thanks Wen. This was maybe rebase damage? Will send a fixup.
yes, I have sent a patch, 6G connect success with this patch, otherwise 
fail for 6G connect.
https://lore.kernel.org/linux-wireless/1606121152-3452-1-git-send-email-wgong@codeaurora.org/
