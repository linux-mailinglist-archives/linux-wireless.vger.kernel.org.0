Return-Path: <linux-wireless+bounces-26464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF95B2CB80
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 19:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19B41771E8
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45305235C1E;
	Tue, 19 Aug 2025 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="s81TXxZx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769430DD1C
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625917; cv=none; b=u5vlJDyjQ0XaaeSVogqxUOZKpdexWapmGAVRSY6qbrI/zhKrZM5W09i2DW4+6slrKDSM3vfSBtNkNtyPrg2/ahiUnCRy5vAd9VttHrbvOuLsD1BRw+J2kAYr378gHG8/c3Sep+hBrCjo8Pbq0QhI8BkPMx5K/y7UKPv4mGKrHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625917; c=relaxed/simple;
	bh=Ch2IlWtNqrjn0wrgZFRlgrL/1+22frgcVSvZnjh/X2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QJq/nACpTAFirKzLwfH3MJH+CsmWsqg++UdppCAaLn9AoHY1dXDZEXE1Vwlx/merrFysT4I7LH6HiW2Dal/6AOgEb0MCRKdGw3FLck9JkYLB+sXkP55qk+a81RBW3evTQXWoh86rU+/widke5wsgSsOQ/2Lg3BfBO1UlrPv0M9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=s81TXxZx; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4WF0yTYc9n711Y+ajfwK4YkO+dvSQwwgfF45QzUAfwo=; b=s81TXxZxPEU8hGtOAf0FOxPBps
	zsf30e0XHQYSM+Aw2r1eKnksStm6GVMtNy8w86eMdO7zRWR6dyudlWthWLTZKVUwvVR1urq6z0h1C
	Q7iJcbEJ8+32GCNc8nl84lfg7onAsN+HNCXHuXiBs08ps8l4vb5vEDjMSySKW0I1OrlE=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uoQUr-00Ce50-1v;
	Tue, 19 Aug 2025 19:51:45 +0200
Message-ID: <57a87dd4-1f6e-4bf7-8fe1-41868cbc5f84@nbd.name>
Date: Tue, 19 Aug 2025 19:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7996: disable beacons when going
 offchannel
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
References: <20250813121106.81559-1-nbd@nbd.name>
 <08f86ed0-32d8-5a8f-2beb-d885dba40232@candelatech.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <08f86ed0-32d8-5a8f-2beb-d885dba40232@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 19:27, Ben Greear wrote:
> On 8/13/25 05:11, Felix Fietkau wrote:
>> Avoid leaking beacons on unrelated channels during scanning/roc
>> 
>> Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
>> Reported-by: Chad Monroe <chad.monroe@adtran.com>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>   .../net/wireless/mediatek/mt76/mt7996/mac.c   | 46 +++++++++++--------
>>   .../net/wireless/mediatek/mt76/mt7996/main.c  |  5 ++
>>   .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 11 +++--
>>   .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
>>   4 files changed, 42 insertions(+), 21 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>> index 6333a064c4f7..d3d3b96f7dd2 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>> @@ -1698,17 +1698,37 @@ mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
>>   static void
>>   mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
>>   {
>> -	struct ieee80211_hw *hw = priv;
>> +	struct ieee80211_bss_conf *link_conf;
>> +	struct mt7996_phy *phy = priv;
>> +	struct mt7996_dev *dev = phy->dev;
>> +	unsigned int link_id;
>> +
>>   
>>   	switch (vif->type) {
>>   	case NL80211_IFTYPE_MESH_POINT:
>>   	case NL80211_IFTYPE_ADHOC:
>>   	case NL80211_IFTYPE_AP:
>> -		mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
>>   		break;
>>   	default:
>> -		break;
>> +		return;
>>   	}
>> +
>> +	for_each_vif_active_link(vif, link_conf, link_id) {
>> +		struct mt7996_vif_link *link;
>> +
>> +		link = mt7996_vif_link(dev, vif, link_id);
>> +		if (link->phy != phy)
>> +			continue;
>> +
>> +		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf);
>> +	}
> 
> Hello Felix,
> 
> We attempted to backport this into our tree, and we found that 'link'
> in the code above is NULL sometimes and we were seeing crashes.  Adding
> a check for null seems to have fixed it.
> 
> Possibly this does not happen in upstream code, so just FYI.

Thanks. I was made aware of the same bug in OpenWrt earlier and I've 
adjusted the commit in my tree accordingly.

- Felix

