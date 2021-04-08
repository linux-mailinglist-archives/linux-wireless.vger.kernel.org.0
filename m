Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF9358B2C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDHRRP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 13:17:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25952 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhDHRRO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 13:17:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617902223; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b6yikkdYlR2Xm7uMj/u2Ep2rjLdAFieCW4OaKQbwYlk=;
 b=fxQWVtI6iQePko/bakdyuALjBqvL0INeVxxXDi6+CI4aStuUOWQcNT9xe7/d9Ok3kE7Nv7YY
 bpse8K0UlZrCMnjQRO8t136586huzvcs2OAznDUMtbcDbX6S/8c0PU6rqgp7N22qEJlRiRrE
 ob31laH5HfYDthG1edZPdLTZhpQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 606f3a868807bcde1dbc8a46 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:16:54
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59C15C43461; Thu,  8 Apr 2021 17:16:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE827C433CA;
        Thu,  8 Apr 2021 17:16:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 08 Apr 2021 10:16:53 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v9 3/4] mac80211: add multiple bssid/EMA support to beacon
 handling
In-Reply-To: <9b475ee0514083ee50c45098bae596fd6a579e89.camel@sipsolutions.net>
References: <20210310182604.8858-1-alokad@codeaurora.org>
 <20210310182604.8858-4-alokad@codeaurora.org>
 (sfid-20210310_192728_682248_F20E9FF1)
 <9b475ee0514083ee50c45098bae596fd6a579e89.camel@sipsolutions.net>
Message-ID: <066c16c890835a3b929e4da7e88c9454@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-08 05:11, Johannes Berg wrote:
> On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
>> 
>> +/**
>> + * enum ieee80211_bcn_tmpl_ema - EMA beacon generation type
>> + * @IEEE80211_BCN_EMA_NONE: don't generate an EMA beacon.
>> + * @IEEE80211_BCN_EMA_NEXT: generate the next periodicity beacon.
>> + * @IEEE80211_BCN_EMA_INDEX: generate beacon by periodicity index
>> + *	if the value is >= this enum value.
>> + */
>> +enum ieee80211_bcn_tmpl_ema {
>> +	IEEE80211_BCN_EMA_NONE	= -2,
>> +	IEEE80211_BCN_EMA_NEXT	= -1,
>> +	IEEE80211_BCN_EMA_INDEX	= 0,
> 
> Maybe call it _BASE instead of _INDEX, it's not really meant to be used
> as is?
> 

Sure

>> +static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
>> +						struct cfg80211_multiple_bssid_data *dest,
>> +						struct cfg80211_multiple_bssid_data *src)
>> +{
>> +	int i;
>> +
>> +	if (!dest || !src)
>> +		return offset;
>> +
>> +	dest->cnt = src->cnt;
>> +	for (i = 0; i < dest->cnt; i++) {
>> +		dest->elems[i].len = src->elems[i].len;
>> +		dest->elems[i].data = offset;
>> +		memcpy(dest->elems[i].data, src->elems[i].data,
>> +		       dest->elems[i].len);
>> +		offset += dest->elems[i].len;
>> +	}
> 
> 
> Following my earlier question - here you just copy all the elements one
> after another, as far as I can tell, so why did they need to be 
> separate
> in the first place? Might be a lot simpler everywhere if all of this 
> was
> just a single buffer, starting from the userspace API?
> 
> 

Separate buffers required as only one buffer is copied when
(ema_index >= IEEE80211_BCN_EMA_INDEX) in
__ieee80211_beacon_get().


>> @@ -4740,13 +4800,11 @@ __ieee80211_beacon_get(struct ieee80211_hw 
>> *hw,
>>  	struct ieee80211_chanctx_conf *chanctx_conf;
>>  	int csa_off_base = 0;
> 
>> -	rcu_read_lock();
>> -
>>  	sdata = vif_to_sdata(vif);
>>  	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
> 
> OK, but ...
> 
>>  struct sk_buff *ieee80211_beacon_get_tim(struct ieee80211_hw *hw,
>>  					 struct ieee80211_vif *vif,
>>  					 u16 *tim_offset, u16 *tim_length)
>>  {
>>  	struct ieee80211_mutable_offsets offs = {};
>> -	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false);
>> +	struct sk_buff *bcn = __ieee80211_beacon_get(hw, vif, &offs, false,
>> +						     IEEE80211_BCN_EMA_NONE);
> 
> You didn't add the protection everywhere.
> 

Will revise this part, thanks for bringing it up.

> johannes
