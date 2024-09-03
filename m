Return-Path: <linux-wireless+bounces-12393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6F96A12F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B4A1C24032
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE91143748;
	Tue,  3 Sep 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QGfCVQ0m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93A6F30D
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375101; cv=none; b=iJVzZ+2DfRJ9dmVTZqtKXCFvXSm2mkGooUo31uGo72MoAizYZv/tPF0bPqP3l660kT9XZEXZRYk5ldvVB+a8XEJg1+tl+rmQcqlwcG6HveEnsHLuGNug53KwIAomT4KraFTiT0h5RtfXWMFznnNC0+NcDAUpF+UtoBgdNlE0A5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375101; c=relaxed/simple;
	bh=D54QX1mvUQVKucrQq/TTEA6iIPNzqgFe91z8M6mxs9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=USM1/QZpdydwH1VgRSArs7JgcwGFDh0vrflaZ5kiBCb/rBFkpcD5DRaaInC30bjZarCjRwpsWx5BfocYlKF0700NY3s8J42NAFBkZXGnOXBVS30QgNmCTf4+QH4zameQdXd2T6Tdqxkg7tuVA5uKnbjDkdwy15zYT5pGFo8i8Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QGfCVQ0m; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9F7A6503F71
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 14:51:37 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CD7FE240074;
	Tue,  3 Sep 2024 14:51:29 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.43.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 26B3313C2B0;
	Tue,  3 Sep 2024 07:51:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 26B3313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1725375089;
	bh=D54QX1mvUQVKucrQq/TTEA6iIPNzqgFe91z8M6mxs9s=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=QGfCVQ0mi8KyOpGwhyyONok5+k2xSFiQE5xSYON/Yu9l0jwZj4bH3ejv+dxT6KEvG
	 zKu6mJbmHqmVznZJ63ch/4GRqO2UMar/O3jl1ImEc5efQr8d1ZKj+OmQyeuBuuaurv
	 Cfy7BZDgluFzaWJGGMe15K40wxHYkO3FQf/jov2E=
Message-ID: <759d8d29-4ffe-434c-aeac-a8c59703c058@candelatech.com>
Date: Tue, 3 Sep 2024 07:51:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] wifi: mac80211: Assign tx-stats to the proper
 link.
To: Johannes Berg <johannes@sipsolutions.net>
References: <20240828155458.1990497-1-greearb@candelatech.com>
 <20240828155458.1990497-2-greearb@candelatech.com>
 <ff685160d8d3c09db31fc8a77963eae2b0eca5b3.camel@sipsolutions.net>
Content-Language: en-MW
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ff685160d8d3c09db31fc8a77963eae2b0eca5b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1725375090-9tfEY8AXY-KB
X-MDID-O:
 us5;at1;1725375090;9tfEY8AXY-KB;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 9/3/24 03:13, Johannes Berg wrote:
> On Wed, 2024-08-28 at 08:54 -0700, greearb@candelatech.com wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> For drivers that can report the tx link-id, account tx
>> stats against that link.  If we cannot determine tx link,
>> then use deflink.
> 
> Strictly speaking, that's not what happens, since the link bits in the
> SKB CB might be set on outgoing frames, and then will still be there on
> the status.

Ok, I can update description to mention that.

> Also using deflink is totally useless for MLO, so maybe just don't do
> anything at all? But might be simpler to just do deflink and document
> that the driver must set this? But not sure that really works so well
> for drivers now.

The stats used to all go to deflink, so that seems a good default, and should
work w/out MLO being enabled.

>> +static struct link_sta_info*
>> +ieee80211_get_tx_link_sta(struct sta_info *sta, struct ieee80211_tx_info *info)
>> +{
>> +	u8 link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
>> +	struct link_sta_info *l_sta_info;
> 
> We usually call that 'link_sta' ...

Yeah, and other similar things are also called link_sta too, which I find confusing.
But I will change it back to be link_sta everywhere I am making changes.

> 
>> @@ -48,6 +65,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
>>   	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>>   	struct ieee80211_hdr *hdr = (void *)skb->data;
>>   	int ac;
>> +	struct link_sta_info *link_sta = ieee80211_get_tx_link_sta(sta, info);
> 
> and even you do, please be consistent with existing code and yourself.
> 
>>
>> +		link_sta = ieee80211_get_tx_link_sta(sta, info);
> 
> Does it really make sense to keep repeating this, rather than passing an
> argument?

Ok, happy to pass this into the handlers.

Thanks,
Ben

> 
> johannes
> 

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


