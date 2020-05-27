Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D71E51DA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgE0Xcf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 19:32:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:48362 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgE0Xce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 19:32:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590622354; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=9Gz/LANfjeSNR228OFq3RM4Wbcf/OEnHdzfHvhy6o6g=;
 b=aWKf1lSgvZ37QJNvMW+Sh58dxAGBP2tOw+0IXZrYg1ZjvqWcCPGg9tV3x7E36ul5tJeWMCkg
 2qURD87ZUEx67o+wEyz4RALJnJPlfncy2XVrGtd8XxBDw4t5EbvPduhf6of7g0UnGBNDHKuk
 BQpiSKFGXEX+P3gwbGGJMaSBgg8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ecef8913131442d953ded0e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 May 2020 23:32:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 12B13C433C6; Wed, 27 May 2020 23:32:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 652C3C433CB;
        Wed, 27 May 2020 23:32:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 16:32:32 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Vamsi Krishna <vamsin@codeaurora.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v3 01/11] cfg80211: use only HE capability to set
 prohibited flags in 6 GHz
In-Reply-To: <7f2a2a382c42b7285b9ad1eeac4e8060bc8d897a.camel@sipsolutions.net>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
 <7f2a2a382c42b7285b9ad1eeac4e8060bc8d897a.camel@sipsolutions.net>
Message-ID: <0fa1c07811796add4a6a23c81cbafe41@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-27 06:43, Johannes Berg wrote:
> Hi,
> 
> This is what we have in this area:
> https://p.sipsolutions.net/d8e56772a261199a.txt
> 
> but I see it's also incomplete.
> 
>> +static bool cfg80211_is_6ghz_freq(u32 freq)
>> +{
>> +	return (freq > 5940 && freq < 7105);
>> +}
> 
> That doesn't really make sense, I don't want to see those hardcoded
> frequencies all over the place.
> 
>>  	case NL80211_CHAN_WIDTH_40:
>>  		width = 40;
>> +		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {
> 
> You can check chandef->chan->band instead. (In fact, we did)
> 
Got it..

>> +			if (!he_cap)
>> +				return false;
>> +			if (!he_cap->has_he_6ghz)
>> +				return false;
> 
> I'm not sure you should even _get_ here with a 6 GHz channel if you
> don't have 6 GHz capability? I mean, why did you register the channel 
> in
> the first place then? This seems unnecessarily complex. If the channel
> didn't exist, it was rejected long before here.
> 
Hmm... Agreed.

> However, looking at D6.0, maybe we do need some checks of the HE
> capability?
> 
>> +			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
>> +			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
>> +				return false;
> 
> Looks like even D6.0 still changed something in this area...
> 
> Evidently our patch just assumed that in 6 GHz all of this is 
> supported,
> but the spec doesn't support that theory :-)
> 
IIUC the same bits are applicable for both 5 GHz & 6 GHz. I understand 
the macro doesn't
capture both.

> Can you respin this with D6.0 taken into account?
> 
Let me check again and respin after your series. Does it sound good?

-Rajkumar
