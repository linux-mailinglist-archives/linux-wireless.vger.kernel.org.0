Return-Path: <linux-wireless+bounces-19529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027DA4769E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 08:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD1D18828AD
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 07:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB3189BB0;
	Thu, 27 Feb 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="VtpjwfLo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA94A1A
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641464; cv=none; b=U8dSm+2lin045+Jw51FJn1LRhvp5vMrPuwVJdvccoiX8ohBe6xVfk0/LHc+wjpZDU4SN6VYD64PIoUgFyVfEZXOTa5vf5fB+OCI7jzs8cwkHeVCdOUV1YxQCwKogkolzvB9y0C29j9p/6C4ExJuO8IBU8ncFCItu2smSLGbeRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641464; c=relaxed/simple;
	bh=/HRe0tLoTn3X/AuSZADdylxMTyB+Fl0nD13bbQ1+Uug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTaz+Oqgb/WEO9Kt+xfDNoVMyc6J65754qb6i+dFK/Wd/LxrFyp1sAWpHme1IHEKWiDE9jaTlHgASILSHPc2fIEXYyfje4WTbux5viwBqeGZRpjVL/tSsqPoBUElw6FkFMatQXPu5L+HtzD77EgxYMLmdA+4ktZlMfhYlt2ZUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=VtpjwfLo; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <8cc9dcda-0968-4aaf-9333-5b484ad8dfd2@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740641457;
	bh=/HRe0tLoTn3X/AuSZADdylxMTyB+Fl0nD13bbQ1+Uug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VtpjwfLood2tHsF9SZuWNp7QnTU/KFW2QjXOnLzSGsxsINNe3Zn4quacQyp0oJhNA
	 AsJtbcpQtF8hphxzG7FZBAmj3j6jhB4lUmUahzlXjU9/E8YLlM7UAtWOZBhQzQjt/b
	 qxZauIATyojXxm6EAIf7LPHwpZDa4d2Fbe1Df+vg=
Date: Thu, 27 Feb 2025 08:30:55 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: remove debugfs dir for virtual monitor
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
References: <20250204164240.370153-1-Alexander@wetzel-home.de>
 <9dd0dd35-5e73-490d-adef-cd45a74a8133@oss.qualcomm.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <9dd0dd35-5e73-490d-adef-cd45a74a8133@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> Alexander
>> ---
>>   net/mac80211/driver-ops.c | 10 ++++++++--
>>   net/mac80211/iface.c      | 11 ++++++-----
>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
>> index 299d38e9e863..2fc60e1e77a5 100644
>> --- a/net/mac80211/driver-ops.c
>> +++ b/net/mac80211/driver-ops.c
>> @@ -116,8 +116,14 @@ void drv_remove_interface(struct ieee80211_local *local,
>>   
>>   	sdata->flags &= ~IEEE80211_SDATA_IN_DRIVER;
>>   
>> -	/* Remove driver debugfs entries */
>> -	ieee80211_debugfs_recreate_netdev(sdata, sdata->vif.valid_links);
>> +	/*
>> +	 * Remove driver debugfs entries.
>> +	 * The virtual monitor interface doesn't get a debugfs
>> +	 * entry, so it's exempt here.
>> +	 */
>> +	if (sdata != local->monitor_sdata)
>> +		ieee80211_debugfs_recreate_netdev(sdata,
>> +						  sdata->vif.valid_links);
> 
> With make W=1 C=1 I'm seeing the following which I think is a result of this
> patch:
> 
> net/mac80211/driver-ops.c:124:19: error: incompatible types in comparison expression (different address spaces):
> net/mac80211/driver-ops.c:124:19:    struct ieee80211_sub_if_data *
> net/mac80211/driver-ops.c:124:19:    struct ieee80211_sub_if_data [noderef] __rcu *
> 
> 

That should be fixed with
https://lore.kernel.org/linux-wireless/20250213214330.6113-1-Alexander@wetzel-home.de/

It has been accepted in the last days, but looks like it was too late 
for wt-2025-02-25.

Alexander

