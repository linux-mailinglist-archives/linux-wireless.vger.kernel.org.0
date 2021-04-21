Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C662367086
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbhDUQtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 12:49:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29079 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237358AbhDUQta (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 12:49:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619023737; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b2vSrMuvPJjOMbW7n080LCHh9qe/uKyEaEDzIt6e9gY=;
 b=YRXmuybUZ2gz8KzUv+quH8pDJLavBy4+6ZW+pyFHyeNc3lUQOnZs7xkudJc0mBJtHmc0YJ5c
 OE1SHx3M9hW38AVz6KhJP9Or3g2MOfEFRixJje7P9jmKmORpcmFgVn+aZwztWopjbrtEQjaD
 jQIub9my0HB/pXGIDSDUxYrW1LE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60805770c39407c32720f120 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 16:48:48
 GMT
Sender: tmariyap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C483C43460; Wed, 21 Apr 2021 16:48:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tmariyap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B532AC433D3;
        Wed, 21 Apr 2021 16:48:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 21 Apr 2021 22:18:46 +0530
From:   Thiraviyam Mariyappan <tmariyap@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2] mac80211: increment rx stats according to USES_RSS flag
In-Reply-To: <c0aef41d2ecf09188de372fe4f7d6b1954e54e07.camel@sipsolutions.net>
References: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org>
 (sfid-20210217_125904_154301_738B3086)
 <c0aef41d2ecf09188de372fe4f7d6b1954e54e07.camel@sipsolutions.net>
Message-ID: <1ee8d562986128767c037d20aedb96a5@codeaurora.org>
X-Sender: tmariyap@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-08 15:31, Johannes Berg wrote:
> On Wed, 2021-02-17 at 17:26 +0530, Thiraviyam Mariyappan wrote:
>> Currently, rx_stats were updated regardless of USES_RSS flag is
>> enabled/disabled. So, updating the rx_stats from percpu pointers
>> according to the USES_RSS flag.
The issue is rx packets not incremented in mesh link and this change 
made to
overcome the issue.
> 
> OK actually, I'm not going to fix the commit log, you'll probably have
> to resend it anyway.
> 
> 
>> @@ -425,7 +426,8 @@ static void mesh_sta_info_init(struct 
>> ieee80211_sub_if_data *sdata,
>>  					&basic_rates);
> 
>>  	spin_lock_bh(&sta->mesh->plink_lock);
>> -	sta->rx_stats.last_rx = jiffies;
>> +	stats = ieee80211_get_rx_stats(&local->hw, sta);
>> +	stats->last_rx = jiffies;
> 
> This doesn't really make much sense? Not sure why that is even updating
> anything at all, it doesn't update anything else?
> 
> Or at least you didn't change anything else, maybe you should have?
>> 
>> @@ -1734,49 +1745,49 @@ ieee80211_rx_h_sta_process(struct 
>> ieee80211_rx_data *rx)
>>  	 * something went wrong the first time.
>>  	 */
>>  	if (rx->sdata->vif.type == NL80211_IFTYPE_ADHOC) {
>> -		u8 *bssid = ieee80211_get_bssid(hdr, rx->skb->len,
>> +		u8 *bssid = ieee80211_get_bssid(hdr, skb->len,
> 
> That seems unrelated.
> 
>> @@ -3625,8 +3648,10 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data 
>> *rx)
>>  	/* queue up frame and kick off work to process it */
>>  	skb_queue_tail(&sdata->skb_queue, rx->skb);
>>  	ieee80211_queue_work(&rx->local->hw, &sdata->work);
>> -	if (rx->sta)
>> -		rx->sta->rx_stats.packets++;
>> +	if (rx->sta) {
>> +		stats = ieee80211_get_rx_stats(&rx->sdata->local->hw, rx->sta);
>> +		stats->packets++;
>> +	}
>> 
> 
> Picking this for no particular reason - everything else in this patch 
> is
> unnecessary since we have rx_path_lock held afaict, so it doesn't
> matter. The whole per-cpu status stuff only matters once you get into
> fast-rx path.
In case of Mesh fast_rx is not applicable, but still USES_RSS can be 
enabled from driver
when parallel RX is supported by HW/Driver, right? Hence checked for 
USES_RSS support to
update per cpu stats.Please correct me if the meaning of USES_RSS is 
misunderstood and
it applies only when fast_rx for a STA is enabled.
> 
> 
> I'd argue that had you written a proper commit log that actually says
> why you need to change things, you'd probably even have noticed these
> issues yourself.
> 
> johannes
