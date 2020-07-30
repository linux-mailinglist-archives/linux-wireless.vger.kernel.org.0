Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A1233A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgG3VAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:00:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15148 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgG3VAX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:00:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596142822; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=fxxfpQjFE7j9Pefgqv5kBAjHj/JoXTgXouVIyWeBpG8=;
 b=tryCOEy+jne+kSdvOaFU/Kj1anIwnP+iGeFpws/V8ggCgPtSNXckAlrZ/Y8NTDtISIjgev3o
 guzDFmV/S/qN49QhdIKBhXG85bOJgLm+pPDtST1m2tljeG412pObfFtJ8/6Z8FpWyv09JthN
 ei/FU6n9jq+kK6CXuEbU2LL/Lg8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f2334d421feae908b5470ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 21:00:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 113B6C433CB; Thu, 30 Jul 2020 21:00:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C654C433C6;
        Thu, 30 Jul 2020 21:00:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jul 2020 14:00:02 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mac80211: Add FILS discovery support
In-Reply-To: <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
References: <20200618050427.5891-1-alokad@codeaurora.org>
 <20200618050427.5891-3-alokad@codeaurora.org>
 <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
Message-ID: <c86a98180879365bab34d8d9eb2f5c3c@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-30 07:47, Johannes Berg wrote:
> On Wed, 2020-06-17 at 22:04 -0700, Aloka Dixit wrote:
> 
>> +++ b/net/mac80211/cfg.c
>> @@ -837,6 +837,33 @@ static int ieee80211_set_probe_resp(struct 
>> ieee80211_sub_if_data *sdata,
>>  	return 0;
>>  }
>> 
>> +static int ieee80211_set_fils_discovery(struct ieee80211_sub_if_data 
>> *sdata,
>> +					struct cfg80211_fils_discovery *params)
>> +{
>> +	struct fils_discovery_data *new, *old = NULL;
>> +	struct ieee80211_fils_discovery *fd;
>> +
>> +	fd = &sdata->vif.bss_conf.fils_discovery;
>> +	fd->min_interval = params->min_interval;
>> +	fd->max_interval = params->max_interval;
>> +
>> +	if (!params->tmpl || !params->tmpl_len) /* Optional template */
>> +		return 0;
> 
> Now I'm even more confused. If the template is optional, then if it's
> not given it doesn't mean *everything* should be ignored, does it?
> 
> What would be the point of that? OTOH, if the template isn't there, 
> what
> would you do?
> 
> But it still doesn't make sense - if no template means you shouldn't do
> anything then that doesn't mean the template should be optional, that
> just means userspace shouldn't even put the NL80211_ATTR_FILS_DISCOVERY
> attribute when it doesn't want anything to be done?
> 
> So it seems to me that something doesn't match. Either the template is
> truly optional and then this shouldn't just return success, or the
> template isn't actually optional?
> 

Everything is not ignored, I set the minimum and maximum interval values 
before checking for the template so that those are accepted even if 
template isn't present.

For 6GHz, template is required, at least for ath11k driver.
But for 2.4GHz and 5GHz FILS discovery transmission is not offloaded to 
FW.

We can make the template mandatory instead and then the respective 
drivers will choose the handling.
Please suggest.

>> +	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery);
>> +	if (err < 0) {
>> +		ieee80211_vif_release_channel(sdata);
>> +		return err;
> 
> Is there no goto label for this error case?
> 

Existing function doesn't use goto labels for error cases, only return.

>> +struct fils_discovery_data {
>> +	struct rcu_head rcu_head;
>> +	int len;
>> +	u8 data[0];
> 
> please use [] not [0].
> 

Will fix in next version.

>> +struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw 
>> *hw,
>> +						  struct ieee80211_vif *vif)
>> +{
>> +	struct sk_buff *skb = NULL;
>> +	struct fils_discovery_data *tmpl = NULL;
>> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +
>> +	if (sdata->vif.type != NL80211_IFTYPE_AP)
>> +		return NULL;
>> +
>> +	rcu_read_lock();
>> +	tmpl = rcu_dereference(sdata->u.ap.fils_discovery);
>> +	if (!tmpl) {
>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	skb = dev_alloc_skb(tmpl->len);
>> +	if (skb)
>> +		skb_put_data(skb, tmpl->data, tmpl->len);
> 
> You should consider the headroom that the driver may have requested.
> 

I didn't understand this point, what would the driver request headroom 
for?
Thanks

> johannes
