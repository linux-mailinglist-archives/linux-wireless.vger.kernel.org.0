Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B373DB68E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 12:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhG3KBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Jul 2021 06:01:51 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:62888 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbhG3KBf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Jul 2021 06:01:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627639278; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6RM5Uu/oSEmhpz4cWgunG9ycHktCXaT1NMpEnZ6L2H0=;
 b=lhjUBwcUSL7hWtpEAjhVxo+XBQ/rjU459idFufhMHHPi8we1OHP7ibWqP088W+nrlYIHpU4n
 lk8hpJAC8ZrvSSYqTjwU2B2BxYkwL7Vu1YC1AJmvkq7OtimTcoUGqDpBw2WNNGj76/qfrc9t
 xLPJwDJ29OZmfCDteVhRhyheoK8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 6103cdd2e81205dd0a46d84b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 30 Jul 2021 10:00:50
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 291A8C43460; Fri, 30 Jul 2021 10:00:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01DB8C433D3;
        Fri, 30 Jul 2021 10:00:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 30 Jul 2021 18:00:48 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/9] cfg80211: add definition for 6G power spectral
 density(psd)
In-Reply-To: <1553c2923cc332acf3da00b49e2d2ac17cc12ba0.camel@sipsolutions.net>
References: <20210517201932.8860-1-wgong@codeaurora.org>
 <20210517201932.8860-5-wgong@codeaurora.org>
 (sfid-20210517_222029_605505_DDB76CEE)
 <1553c2923cc332acf3da00b49e2d2ac17cc12ba0.camel@sipsolutions.net>
Message-ID: <03159ab593d309353d69cd65db0a8da8@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-07-23 17:24, Johannes Berg wrote:
> On Mon, 2021-05-17 at 16:19 -0400, Wen Gong wrote:
>> 
>> + * @IEEE80211_CHAN_PSD: power spectral density (in dBm)
>> + *	on this channel.
> 
> Do we need that? Which really is just another way of asking
> 
>> + * @psd: power spectral density (in dBm)
> 
> whether or not 0 is a valid value for this?
yes, 0 is also a valid value.
It also have negative, such as -1dBm.
> 
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -4040,6 +4040,7 @@ enum nl80211_sched_scan_match_attr {
>>   * @NL80211_RRF_NO_80MHZ: 80MHz operation not allowed
>>   * @NL80211_RRF_NO_160MHZ: 160MHz operation not allowed
>>   * @NL80211_RRF_NO_HE: HE operation not allowed
>> + * @NL80211_RRF_PSD: channels has power spectral density value
> 
> It doesn't seem like we need this, after all, there must be some kind 
> of
> attribute for the PSD, and then its presence/absence already indicates
> this?
Now the psd value 0 is also a valid value, so now we can not consider 
the
psd 0 as NON-PSD, so we need this flag to check it is psd or NON-psd.
> 
> johannes
