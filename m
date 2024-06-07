Return-Path: <linux-wireless+bounces-8687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF159003B9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 14:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4536282CEE
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05E18F2D9;
	Fri,  7 Jun 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="lEgWgf7T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D424AEC3
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763822; cv=none; b=ECt/WcIna+yXftpyHXn6Pq1xy2rH7PWC7O1XqMxoO7JEVltW84vMgaoJxVRzqYIbI8YCOULC0Jx4C6qcLdp31p197fgCOFlfzKGWshoddvFoZGxmvJnzU4Ih6bKXHQ6nZ78fd6Ef3guRvXk/ln/SNY30wEAKyTijrGOU19ciZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763822; c=relaxed/simple;
	bh=Is4GtUvGhOk206no8dsxyEASqKiT3h6sPVHoIEHqZmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pap0v+8uXd1cWqIsopJ88dTq1tcV5xs5TkoM+vkCOIZLbk5exs8ghhF/GFXiA00K0u5X3LTBdXxvPqYMVlWX72PRRKJvP/FkrA+rMjMiH77LpMYuBo8hjb/KnS8Knmy1mgpy+Ome3mN17Szqe0mlhCzeMB4krrqbKMnpR48pimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=lEgWgf7T; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EONA58GKhxEWo7KfkjqILqtjinFUj4gxSIC87MiQUaw=; b=lEgWgf7Tkix7IWlFe3KQYpzFaV
	5xpQMmNxkAKNjzfjb4PclbwJK7xKmo3blfRrhTtjx9VbpgfXVVTP/PVvlbZ9nCh3Qj2aRi/9xTiDM
	EVww+MHXreDqoOAvMMegC3e05qlJ5RHN2uiHZ+amTTjrtjd56M3PB/ld9mkhjtfl8ebE=;
Received: from p4ff13226.dip0.t-ipconnect.de ([79.241.50.38] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFYq0-008tfH-3C;
	Fri, 07 Jun 2024 14:36:57 +0200
Message-ID: <f935ca94-9380-4b3c-9da2-3d26392bc875@nbd.name>
Date: Fri, 7 Jun 2024 14:36:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/8] wifi: cfg80211: extend interface combination check
 for multi-radio
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <754815488294f5b7f599b2adba085f1889b53b1a.1717696995.git-series.nbd@nbd.name>
 <65e01dcab3e934b1295fe64d9d311bd1fbdd2665.camel@sipsolutions.net>
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
In-Reply-To: <65e01dcab3e934b1295fe64d9d311bd1fbdd2665.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 11:32, Johannes Berg wrote:
> On Thu, 2024-06-06 at 20:07 +0200, Felix Fietkau wrote:
>> 
>> @@ -4577,6 +4579,7 @@ struct mgmt_frame_regs {
>>   *
>>   * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
>>   * @set_ttlm: set the TID to link mapping.
>> + * @get_radio_mask: get bitmask of radios in use
>>   */
>>  struct cfg80211_ops {
>>  	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
>> @@ -4938,6 +4941,8 @@ struct cfg80211_ops {
>>  				    struct cfg80211_set_hw_timestamp *hwts);
>>  	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
>>  			    struct cfg80211_ttlm_params *params);
>> +	int	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev,
>> +				  u32 *mask);
> 
> 
> not sure I see the point of this being a callback rather than being
> passed in?
> 
> (Also, if really needed, do you actually expect a device with 32 radios?
> if not you can use a return value instead of u32 *mask out pointer :) )

I'll update the callback to return u32

>> +DEFINE_EVENT(wiphy_netdev_evt, rdev_get_radio_mask,
>> +	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
>> +	TP_ARGS(wiphy, netdev)
>> +);
> 
> and if we do need it that really should trace not just the fact that it
> happened but also the return value and mask
> 
>>  static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
>>  				       u32 *beacon_int_gcd,
>> -				       bool *beacon_int_different)
>> +				       bool *beacon_int_different,
>> +				       const struct wiphy_radio *radio)
>>  {
>> +	struct cfg80211_registered_device *rdev;
>>  	struct wireless_dev *wdev;
>> +	int radio_idx = -1;
>>  
>>  	*beacon_int_gcd = 0;
>>  	*beacon_int_different = false;
>> +	if (radio)
>> +		radio_idx = radio - wiphy->radio;
> 
> This can go oh so wrong ... and technically even be UB. I'd rather pass
> the index from the driver, I guess, and validate it against n_radios.

Will pass the index in directly.

>> +	rdev = wiphy_to_rdev(wiphy);
>>  	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
>>  		int wdev_bi;
>> +		u32 mask;
>>  
>>  		/* this feature isn't supported with MLO */
>>  		if (wdev->valid_links)
>>  			continue;
> 
> Are we expecting this to change? because the premise of this patchset is
> MLO support, and yet with real MLO we won't get here?
> 
> Or is that because non-MLO interfaces could be created on this wiphy?

Not sure about this. I guess we can revisit it later since it's out of 
scope for this series.

>>  
>> +		if (radio_idx >= 0) {
>> +			if (rdev_get_radio_mask(rdev, wdev->netdev, &mask))
>> +				continue;
> 
> 
> here: given that 'radio'/'radio_idx' is passed in, not sure I see why
> the mask couldn't also be passed in?

mask is supposed to be per wdev, which is iterated in a loop here.

> 
>> +			if (!(mask & BIT(radio_idx)))
>> +				continue;
> 
> that could use a comment
> 
>> -	for (i = 0; i < wiphy->n_iface_combinations; i++) {
>> -		const struct ieee80211_iface_combination *c;
>> +	if (radio) {
>> +		c = radio->iface_combinations;
>> +		n = radio->n_iface_combinations;
>> +	} else {
>> +		c = wiphy->iface_combinations;
>> +		n = wiphy->n_iface_combinations;
>> +	}
>> +	for (i = 0; i < n; i++, c++) {
> 
> that c++ is a bit too hidden for my taste there, but YMMV and I guess if
> I wasn't reading the diff it'd be more obvious :)

Will move it into the loop body to make it more obvious.

Thanks,

- Felix


