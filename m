Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3AE3B6776
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 19:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhF1RTZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 13:19:25 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41100 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbhF1RTY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 13:19:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624900619; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0HxhNAhRliCFF+rvuk/wLzlKMmnUBHAvobMK4tGIuJc=;
 b=gkuqq9ByWCiTjidd05z3a6RTAYXPtJLEekcusLqMBW8SbxQAxO+OIsSOeOJRkWt4kHpcEFWS
 9z9bxo6mi1G7lnAjwFvm65x36ybrEDMRWaa2fjbay+d8oQ+0iphkzc6l4WRH5poIjxm0wxKF
 Rg0yTx/yP7n9gFQsZ2ElUv25y7A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60da03ed4ca9face349832a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Jun 2021 17:16:29
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8C469C433D3; Mon, 28 Jun 2021 17:16:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC195C433F1;
        Mon, 28 Jun 2021 17:16:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 28 Jun 2021 10:16:26 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v10 2/4] mac80211: multiple bssid support in interface
 handling
In-Reply-To: <6dc09b7dcfef37a703e95e264e6ab64738560160.camel@sipsolutions.net>
References: <20210426190534.12667-1-alokad@codeaurora.org>
 <20210426190534.12667-3-alokad@codeaurora.org>
 <6dc09b7dcfef37a703e95e264e6ab64738560160.camel@sipsolutions.net>
Message-ID: <9451f0db49f603d7e9a00d172ab341e2@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-23 08:57, Johannes Berg wrote:
> On Mon, 2021-04-26 at 12:05 -0700, Aloka Dixit wrote:
>> 

> Hm wait, didn't I see the same code in cfg80211 - maybe cfg80211 should
> just pass the pointer?
>> 
>>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
>> wireless_dev *wdev)
>>  {
>> +	struct ieee80211_sub_if_data *sdata = 
>> IEEE80211_WDEV_TO_SUB_IF(wdev);
>> +	struct ieee80211_local *local;
>> +	struct ieee80211_vif *vif;
>> +
>> +	if (!sdata)
>> +		return 0;
>> +
>> +	local = sdata->local;
>> +	vif = &sdata->vif;
>> +	if (vif->type == NL80211_IFTYPE_AP &&
>> +	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP)) {
>> +		if (vif->mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
>> +			struct ieee80211_sub_if_data *child, *tmpsdata;
>> +
>> +			wiphy_unlock(local->hw.wiphy);
>> +			mutex_lock(&local->iflist_mtx);
> 
> I really don't think you can drop the locking like that in the middle 
> of
> something. That's almost always a recipe for disaster.
> 
>> @@ -375,6 +375,18 @@ static void ieee80211_do_stop(struct 
>> ieee80211_sub_if_data *sdata, bool going_do
>>  	struct cfg80211_chan_def chandef;
>>  	bool cancel_scan;
>>  	struct cfg80211_nan_func *func;
>> +	struct ieee80211_sub_if_data *parent;
>> +
>> +	if (sdata->vif.type == NL80211_IFTYPE_AP &&
>> +	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP) &&
>> +	    sdata->vif.mbssid.flags & IEEE80211_VIF_MBSSID_NON_TX) {
>> +		parent = vif_to_sdata(sdata->vif.mbssid.parent);
>> +		if (parent && ieee80211_sdata_running(parent)) {
>> +			wiphy_unlock(local->hw.wiphy);
>> +			dev_close(parent->wdev.netdev);
>> +			wiphy_lock(local->hw.wiphy);
> 
> Same here.
> 
> johannes

Hi Johannes,

Thanks for the comments, will go through all, but need your help with 
this particular one -

I'm not able to come up with a different solution which does not cause a 
deadlock by continuing to hold wiphy_lock() as we discussed last time 
that dev_close() will in turn call into cfg80211.

You had suggested looking at dev_close() for VLAN, that code also 
doesn't lock wiphy_lock hence I did same here but locked 
'local->iflist_mtx'. Dropping both won't be good for sure.

Can you please suggest a better way? I'm really not able to come up with 
one.

Thanks.
