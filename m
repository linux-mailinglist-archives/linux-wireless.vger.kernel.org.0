Return-Path: <linux-wireless+bounces-8621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A218FE87C
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE94C1C22F50
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7577196C9F;
	Thu,  6 Jun 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="mEKtVvqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADADC196434
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682899; cv=none; b=AtKWI42tIRglqJQqs4j67KUWnYxBybT5XoZFYVMRqmg4M0KIZFZwwNTBk+IcJYECB/iCRjZX26WPs3LJblhgKn2XgF8eBolnFfpeJOY+xCIc8B261aSHTgxhR3I/5duXSaIRG3QT68Ry68KEpLgP1XCjxes3TY/kBTZeaMIl33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682899; c=relaxed/simple;
	bh=jkMjws0Zw8EqqwZk/tginwSSKdfcEADVWvQgI8/3O8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfPyBmHK1fjvFRNdwNGtZweXF8Dqy/o7FAesY3zBFCiG0VWGTVlj0xDmPglOYdQbZUC18JfbTpDNSv58aftdyuwogD3+l/M3qPLi3uUzHr6b5QuIGNUkG4ydmUPbf2iVUBzcuiyF0uyyITBAxKNPRWBbQJOpXTcwMbGvqr3ETa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=mEKtVvqg; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7F4D32C5B3A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 13:50:05 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9DC8A280079;
	Thu,  6 Jun 2024 13:49:57 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.32.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 06F2813C2B0;
	Thu,  6 Jun 2024 06:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 06F2813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1717681797;
	bh=jkMjws0Zw8EqqwZk/tginwSSKdfcEADVWvQgI8/3O8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mEKtVvqg2toIf0BdH+NrF+AJpHQWAEfFUsizWelgc2vATD2cexF6DeIuejg5VD1/b
	 5VBSFlh1ednudkbgzaxlkSN9kcu1CpyfVY38mZ4cn9tgZ5cNHfPKPS6QB6BdHiFNbh
	 gPnytIQRYwIXNbcu1+CPuqA22ZTl9tC2NXuOsaQI=
Message-ID: <2bcadb06-2a4e-4603-945c-839d92ace8fa@candelatech.com>
Date: Thu, 6 Jun 2024 06:49:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mac80211: scan ignores next_delay calculation after first probe
To: Sven Eckelmann <sven@narfation.org>,
 Michael-CY Lee <michael-cy.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net
References: <2540184.6tgchFWduM@ripper>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <2540184.6tgchFWduM@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1717681798-bf1fHyjLsWQD
X-MDID-O:
 us5;ut7;1717681798;bf1fHyjLsWQD;<greearb@candelatech.com>;379d68f987f1c6aa3382c280fa0edf54

On 6/5/24 23:27, Sven Eckelmann wrote:
> Hi,
> 
> I was debugging some problems when trying to scan for BSS (and they were often
> not recorded on channel 1) and noticed some potential problems with some code
> changes by you. Not necesserily the changes itself but the parts which look a
> little bit like they were missed.
> 
> With your commit d60277ac3fc9 ("wifi: mac80211: apply duration for SW scan"),
> I can now set the duration in SW scans (thank you). But __ieee80211_start_scan
> just overwrites the calculated next delay of ieee80211_scan_state_send_probe.
> So for the first channel, the duration still seems to be wrong.
> 
> In the past, the version from Ben Greear just overwrote the value
> IEEE80211_CHANNEL_TIME (from ieee80211_scan_state_send_probe) with the value
> IEEE80211_CHANNEL_TIME in __ieee80211_start_scan. This slightly odd behavior
> was introduced in 8a690674e060 ("mac80211: Support on-channel scan option.").
> And even when it didn't made a lot of sense to me - it didn't change the
> behavior. But now it seems to be counter productive. Maybe you can check this
> again and maybe Ben Greear still remembers why this there in the first place.

Hello Sven,

It's been a long time, I don't recall the exact details.  But my goals were
to have minimal impact when we are scanning only the current working channel.
Shouldn't need to do any off-channel work, stop other traffic, or add
extra delay in that case.

Thanks,
Ben

> 
> The discussion is about this part (which overwrites the correct value for
> next_delay):
> 
> static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
> 				  struct cfg80211_scan_request *req)
> {
> [snip]
> 	if (hw_scan) {
> 		__set_bit(SCAN_HW_SCANNING, &local->scanning);
> 	} else if ((req->n_channels == 1) &&
> 		   (req->channels[0] == local->hw.conf.chandef.chan)) {
> [snip]
> 
> 		if ((req->channels[0]->flags & (IEEE80211_CHAN_NO_IR |
> 						IEEE80211_CHAN_RADAR)) ||
> 		    !req->n_ssids) {
> 			next_delay = IEEE80211_PASSIVE_CHANNEL_TIME;
> 			if (req->n_ssids)
> 				set_bit(SCAN_BEACON_WAIT, &local->scanning);
> 		} else {
> 			ieee80211_scan_state_send_probe(local, &next_delay);
> 			next_delay = IEEE80211_CHANNEL_TIME;
> 		}
> [snip]
> }
> 
> 
> And here is the code in for ieee80211_scan_state_send_probe which always sets
> next_delay to the correct value:
> 
> static void ieee80211_scan_state_send_probe(struct ieee80211_local *local,
> 					    unsigned long *next_delay)
> {
> [snip]
> 	/*
> 	 * After sending probe requests, wait for probe responses
> 	 * on the channel.
> 	 */
> 	*next_delay = msecs_to_jiffies(scan_req->duration) >
> 		      IEEE80211_PROBE_DELAY + IEEE80211_CHANNEL_TIME ?
> 		      msecs_to_jiffies(scan_req->duration) - IEEE80211_PROBE_DELAY :
> 		      IEEE80211_CHANNEL_TIME;
> 	local->next_scan_state = SCAN_DECISION;
> }
> 
> 
> 
> And maybe you have also noticed that your patch missed the calculation for the
> passive scan in __ieee80211_start_scan. It always sets it to
> IEEE80211_PASSIVE_CHANNEL_TIME. But I would have guessed that the calculation
> should also be
> 
> next_delay = msecs_to_jiffies(scan_req->duration) > IEEE80211_PASSIVE_CHANNEL_TIME ?
> 	  msecs_to_jiffies(scan_req->duration) :
> 	  IEEE80211_PASSIVE_CHANNEL_TIME;
> 
> 
> Another part which seem to have been missed by your patch is the
> scan_state_decision helper code in ieee80211_scan_get_channel_time. It looks
> to me like it could now under-estimate the scan time because it doesn't handle
> the duration information.
> 
> 
> Kind regards,
> 	Sven

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


