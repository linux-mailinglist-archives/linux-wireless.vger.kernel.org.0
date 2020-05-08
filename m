Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD791CBB5C
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 01:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgEHXpu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 19:45:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16290 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbgEHXpu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 19:45:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588981549; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=C4glG4DpKY0AN9bUFpM03dyggL13Kv7UgANPlRzpyvs=;
 b=mYqWlV1+83D7VLK4+VqrmTCZM5M81gT3R3/Se1ZY6s3FdX1bteumQ1P0618rn2EvoxokXS78
 f6+UnAaaM7wMljzSOsaiiXpgABXzhIAGFS54uHcDRpX70vLiD/6J+VtNR40/G3Ql3RjzY4y8
 g8WRAGHfehKaNidVnV8sV7SlGQA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5ef15.7f352d825c38-smtp-out-n01;
 Fri, 08 May 2020 23:45:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34AB5C43636; Fri,  8 May 2020 23:45:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C292BC433D2;
        Fri,  8 May 2020 23:45:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 May 2020 16:45:23 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     johannes@sipsolutions.net, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v2 10/11] mac80211: determine chantype from HE operation
 in 6 GHz
In-Reply-To: <29370be316eca4d5592baeeaa6c1a779@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
 <1588285252-30034-10-git-send-email-rmanohar@codeaurora.org>
 <29370be316eca4d5592baeeaa6c1a779@codeaurora.org>
Message-ID: <f25026eaf2fd718fba35b1a5cfaafd8f@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-08 15:53, Pradeep Kumar Chitrapu wrote:
>> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
>> index b4dfefd482a6..9115dc9c7d78 100644
>> --- a/net/mac80211/mlme.c
>> +++ b/net/mac80211/mlme.c
>> @@ -163,6 +163,9 @@ ieee80211_determine_chantype(struct
>> ieee80211_sub_if_data *sdata,
>>  	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
>>  	chandef->center_freq1 = channel->center_freq;
>> 
>> +	if (channel->band == NL80211_BAND_6GHZ)
>> +		goto skip_ht_vht_oper;
>> +
>>  	if (!ht_oper || !sta_ht_cap.ht_supported) {
>>  		ret = IEEE80211_STA_DISABLE_HT |
>>  		      IEEE80211_STA_DISABLE_VHT |
>> @@ -263,6 +266,15 @@ ieee80211_determine_chantype(struct
>> ieee80211_sub_if_data *sdata,
>> 
>>  	*chandef = vht_chandef;
>> 
>> +skip_ht_vht_oper:
>> +	if (!ieee80211_chandef_he_oper(sdata, he_oper, chandef)) {
>> +		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
>> +			sdata_info(sdata,
>> +				   "AP HE information is invalid, disable HE\n");
>> +		ret = IEEE80211_STA_DISABLE_HE;
>> +		goto out;
>> +	}
>> +
> Hi Rajkumar,
> Above is causing to disable HE in STA mode even when AP supports HE.
> Shouldn't this be done only for 6GHz band?
> something like below?
> if (channel->band == NL80211_BAND_6GHZ &&
>     !ieee80211_chandef_he_oper(sdata, he_oper, chandef))
> 
Good catch.

>> +
>> +	he_cap = ieee80211_get_he_iftype_cap(sband, sdata->vif.type);
>> +	if (!he_cap)
>> +		return false;
>> +
> or return true here if band is not NL80211_BAND_6GHZ?
> 
Make sense. Will address it.

-Rajkumar
