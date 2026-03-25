Return-Path: <linux-wireless+bounces-33801-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFPANnJfw2m1qQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33801-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:07:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 168BF31F758
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 05:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF79300F5E8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 03:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44CCA5A;
	Wed, 25 Mar 2026 03:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hmQkn1zw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2A2DCF72
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411107; cv=none; b=X69WPQhuDAYbKW8Updl12BnVJP1CEZQZVJuXI/CF2I9VcI6xbKRcWPzvqYSRJuXZNyFC7d2hOWtd8UVk/d8ri9vcHMfBQrZ/BWNDJjOivCq1ERUsYbcCzNl1/sAZn2VlyRJOHGHxtou5quwnisy7nhdtvZtteEotD8DkxhlH26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411107; c=relaxed/simple;
	bh=iE3xjGVJ/6eu6GxRtQOyXtaGtJ7EZSG44jZWzVYoqrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWU9E88ktVsVhaxlTGpe4KttubBZqJ5gRHd/mGllmKzbPOAG1JhkCIp2+85LvKTs0MGfEijoMvt5134c5mlF5yPHDYp5e1ZGOrC3RIlA8PT7O1j2XJrNNDG5ERHpySUla5CWiO2T5JfpSnWL/94aIRYeRPjbg3UsMAY0T6tSDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hmQkn1zw; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9Ex7hD80hBVTRRmfINP5eftE39Fv+TMGzzOpyC6G5U=; b=hmQkn1zw8vzE0CE5Ery/OUnYR/
	FqYs40TWNc8dJ4kZ5R/D0s35vT2JFCLnzrfOBcWyhgGAaL7jlWUEgU8uQxM9EU6FMDxKa403NdcPw
	MF1crHpdqjXoWA7/WDlINxxoPjTWFeghgOCpgFKhD7y6Y11eSbiGea2kTKcaM3WWakUY=;
Received: from p200300cadf082f0005b2d20964363def.dip0.t-ipconnect.de ([2003:ca:df08:2f00:5b2:d209:6436:3def] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1w5FNw-00BrXb-0L;
	Wed, 25 Mar 2026 04:58:24 +0100
Message-ID: <0f56f76d-7820-4392-88f7-78f24b9ff421@nbd.name>
Date: Wed, 25 Mar 2026 04:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] wifi: mac80211: factor out part of
 ieee80211_calc_expected_tx_airtime
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20260323101954.874299-1-nbd@nbd.name>
 <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
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
In-Reply-To: <900aa78e-b0ca-43de-adae-4053bde4d328@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33801-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nbd.name:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:email,nbd.name:mid]
X-Rspamd-Queue-Id: 168BF31F758
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23.03.26 17:00, Pablo MARTIN-GOMEZ wrote:
> Hello,
> 
> On 23/03/2026 11:19, Felix Fietkau wrote:
>> Create ieee80211_rate_expected_tx_airtime helper function, which returns
>> the expected tx airtime for a given rate and packet length in units of
>> 1024 usec, for more accuracy.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/mac80211/airtime.c     | 87 ++++++++++++++++++++++----------------
>>  net/mac80211/ieee80211_i.h |  5 +++
>>  2 files changed, 56 insertions(+), 36 deletions(-)
>> 
>> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
>> index c61df637232a..0c54cdbd753c 100644
>> --- a/net/mac80211/airtime.c
>> +++ b/net/mac80211/airtime.c
>> @@ -685,7 +685,7 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
>>  	if (ieee80211_fill_rate_info(hw, stat, band, ri))
>>  		return 0;
>>  
>> -	if (!ieee80211_rate_valid(rate))
>> +	if (!rate || !ieee80211_rate_valid(rate))
>>  		return -1;
>>  
>>  	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
>> @@ -753,6 +753,53 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>>  }
>>  EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
>>  
>> +u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
>> +				       struct ieee80211_tx_rate *tx_rate,
>> +				       struct rate_info *ri,
>> +				       enum nl80211_band band,
>> +				       bool ampdu, int len)
>> +{
>> +	struct ieee80211_rx_status stat;
>> +	u32 duration, overhead;
>> +	u8 agg_shift;
>> +
>> +	if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
>> +		return 0;
>> +
>> +	if (stat.encoding == RX_ENC_LEGACY || !ampdu)
>> +		return ieee80211_calc_rx_airtime(hw, &stat, len) * 1024;
>> +
>> +	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
>> +
>> +	/*
>> +	 * Assume that HT/VHT transmission on any AC except VO will
>> +	 * use aggregation. Since we don't have reliable reporting
>> +	 * of aggregation length, assume an average size based on the
>> +	 * tx rate.
>> +	 * This will not be very accurate, but much better than simply
>> +	 * assuming un-aggregated tx in all cases.
>> +	 */
>> +	if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
>> +		agg_shift = 1;
>> +	else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
>> +		agg_shift = 2;
>> +	else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
>> +		agg_shift = 3;
>> +	else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
>> +		agg_shift = 4;
>> +	else if (stat.encoding != RX_ENC_HE ||
>> +		 duration > 20 * 1024) /* <= HE40 MCS6 2S */
>> +		agg_shift = 5;
>> +	else
>> +		agg_shift = 6;
>> +
>> +	duration *= len;
>> +	duration /= AVG_PKT_SIZE;
>> +	duration += (overhead * 1024 >> agg_shift);
> I know this patch is just a refactoring, but I think this moved code is
> bugged. If (and it's a big if) I understood correctly the chain of
> macros and the comments, `ieee80211_get_rate_duration` return the
> `duration` in 1024 µs of an average packet (which would imply
> 1f38b8c564b8 is wrong) and the (PHY) `overhead` in µs for a (average)
> packet. So I believe the code should be:
> ```c
> 	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
> 	duration *= 1024;  /* now duration is in µs */
> 	/* the agg_shift calculation has to be fixed */
> 	duration += (overhead >> agg_shift);  /* for one packet, we "assign" a
> fraction of the overhead */
> 	duration *= len/AVG_PKT_SIZE;  /* we multiply by the number of packets */
> 	duration /= 1024;  /* we go back to a duration in 1024 µs*/
> 
> 	return duration;
> ```

The overhead (preamble, signal field, etc.) is a fixed per-frame PHY 
cost that doesn't depend on how many data bytes are in the frame. In the 
aggregated case, agg_shift amortizes that fixed cost across the 
estimated number of subframes in the aggregate. So the correct order is: 
scale the data duration to the actual packet size, then add the 
amortized overhead once.
This is the same pattern used in ieee80211_calc_rx_airtime:

   duration *= len;
   duration /= AVG_PKT_SIZE;
   duration /= 1024;
   return duration + overhead;

Your proposed rewrite would multiply the overhead by len / AVG_PKT_SIZE, 
making it proportional to packet size, which is incorrect, because a 
512-byte frame and a 1500-byte frame have the same PHY preamble duration.

- Felix

