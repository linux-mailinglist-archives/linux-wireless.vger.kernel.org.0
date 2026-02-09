Return-Path: <linux-wireless+bounces-31675-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOnpJ21gimlIJwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31675-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 23:32:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAD111511D
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92742300908E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EA318B9F;
	Mon,  9 Feb 2026 22:32:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94915317715
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770676329; cv=none; b=l3k84qo3B+4l2KR0D/qeO5N3MudTXA8jtUAsz7ogz8cSgDVG2Taj5u0TCuBl0mzsOlvXfyE/CpsMXt+dGADA7HsvZ0pxaKwX+zCD0iri4aSI3AIe/fjxLgOrsJa+9QMGBQIyzS9H8vnTy7wthFVW4qlSdX+CjUwo7Dfnf+92Ixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770676329; c=relaxed/simple;
	bh=8/6GWJ78cCEmR87Xzu9Nvk8Da94Osc7wG9m79klcitU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=socp+fwYD5Cn48kMCMrsrpOSWy5evPsK6AUgWUcS8Pt2hXRnsY/VkaTqTvsA6vZHhHht7ejeJ7b+d8rHbHaZENE2x/w+qWvjQRSMkM2SZin4AcCzgI0i9m7fomZDhUwRPuhekRsynSN8r3+DG9u7oTXyXRYDdvJngPBlrKIfhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af736.dynamic.kabel-deutschland.de [95.90.247.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CEE864C4430B0E;
	Mon, 09 Feb 2026 23:31:28 +0100 (CET)
Message-ID: <2c722676-98c6-4162-96cb-9bea06672153@molgen.mpg.de>
Date: Mon, 9 Feb 2026 23:31:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
 <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31675-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Queue-Id: 4DAD111511D
X-Rspamd-Action: no action

Dear Baochen,


Am 09.02.26 um 03:44 schrieb Baochen Qiang:

> On 2/7/2026 1:55 PM, Paul Menzel wrote:

>> Am 19.01.26 um 17:41 schrieb Paul Menzel:
>>
>>> Since January 10th, I have started seeing the warning below in
>>> my Linux logs, that reach back to September 24th, 2025:
>>>
>>>       [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>>       [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>>
>>> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the
>>> version running before is 6.19.0-rc4-00003-g3609fa95fb0f, but I
>>> do not see anything related in the commit list:>>>
>>>       git log --oneline 3609fa95fb0f...b6151c4e60e5
>>>
>>> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there
>>> since 2021.
>>> 
>>> Do you have an idea? Please find the output of `dmesg` attached.
>> 
>> Looking through the commit list from above again, commit
>> a203dbeeca15 (wifi: mac80211: collect station statistics earlier
>> when disconnect) probably introduced the new behavior.
> 
> is this error seen when disconnecting from AP?

I attached the logs in my first message. But yes, it looks like this:

     Feb 07 06:32:52 abreu kernel: wlp58s0: deauthenticating from 
74:1a:e0:e7:b4:c8 by local choice (Reason: 3=DEAUTH_LEAVING)
     Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: not found 
station for peer stats
     Feb 07 06:32:52 abreu kernel: ath10k_pci 0000:3a:00.0: failed to 
parse stats info tlv: -22
     Feb 07 06:32:52 abreu wpa_supplicant[846]: wlp58s0: 
CTRL-EVENT-DISCONNECTED bssid=74:1a:e0:e7:b4:c8 reason=3 locally_generated=1
     Feb 07 06:32:52 abreu wpa_supplicant[846]: BSSID 74:1a:e0:e7:b4:c8 
ignore list count incremented to 2, ignoring for 10 seconds

> did you try with that commit reverted?
Yes, I tried it now with Linux 6.19 and reverting the commit. The 
warnings are gone now.

Are you able to reproduce the issue? What devices are you testing with?


Kind regards,

Paul

