Return-Path: <linux-wireless+bounces-34672-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKdcICGn22kSEwkAu9opvQ
	(envelope-from <linux-wireless+bounces-34672-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 16:07:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D843E424F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 16:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B76301A922
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DAB2DE6FF;
	Sun, 12 Apr 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="dp5V3ynI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F42C08BB
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002647; cv=none; b=NNkZNoSf4EbSD6c11OthmyJc7oZUN9il6Wpk8592eN3+MLc/uA0JoZmYa1priNmqSwgUZflVM3nU/zeollyLHJ9JG9NR3fpLi5JefqBPPzYXqXAac5yuhsj4XTH9BgCJXQR22XfqzWr6n+om0BXaT+pc5ZRvReV8cFGwmcaICBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002647; c=relaxed/simple;
	bh=HgFVOXbJcp0bLsKjicXpTOp4qHHRJdpvNDmHDbqBkEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdtWB8WuGqUWvaxzwqDBwDJ2Oz6Jbp84cOrJlgu+9dTgE1qLzlqe9Oy7+UOxHvIOyWz0Gd2pDQqLKXI80JSsNC7Eiq1zIqvTKc1JRgLYOzL+pSKaQoyuBoCF9sEbyLjwW7mfT/FrNPz7iELg7oAn/L+Uc92UOPPJY/KVYV5ILBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=dp5V3ynI; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9C613B00061;
	Sun, 12 Apr 2026 14:03:57 +0000 (UTC)
Received: from [10.252.54.110] (unknown [198.134.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DDB1313C2B0;
	Sun, 12 Apr 2026 07:03:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DDB1313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1776002634;
	bh=HgFVOXbJcp0bLsKjicXpTOp4qHHRJdpvNDmHDbqBkEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dp5V3ynIAj7hzuEx73YmuJK1hRsvvqpUGOKbJK2T/Hz6ZSY194Izgjo3RCIQWFFDJ
	 jCCpTjGKhryd4lnuOnsnOEzAj8vcqpkiY9xUmh9N4OnXlfIT+FEPRfFoncaeuwK8MD
	 TuRCcQl912ZnW1jCXbkTiH3aqfgjwBLP5Om0mvfE=
Message-ID: <d74eb2fd-5698-425b-8650-f136c9442155@candelatech.com>
Date: Sun, 12 Apr 2026 07:03:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: iwlwifi: mld: fix TSO segmentation explosion
 when AMSDU is disabled
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 Cole Leavitt <cole@unwrap.rs>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>
References: <20260405054145.1064152-1-cole@unwrap.rs>
 <20260405054145.1064152-3-cole@unwrap.rs>
 <DS0PR11MB788029013A25A284B0907D01A3272@DS0PR11MB7880.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <DS0PR11MB788029013A25A284B0907D01A3272@DS0PR11MB7880.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1776002638-bLx3YiuNvite
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1776002638;bLx3YiuNvite;<greearb@candelatech.com>;9db8dd06de60c557760218eb2301c105
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34672-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,candelatech.com:dkim,candelatech.com:mid,candelatech.com:email,candelatech.com:url,unwrap.rs:email]
X-Rspamd-Queue-Id: C8D843E424F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 8:47 PM, Korenblit, Miriam Rachel wrote:
> 
> 
>> -----Original Message-----
>> From: Cole Leavitt <cole@unwrap.rs>
>> Sent: Sunday, April 5, 2026 8:42 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: greearb@candelatech.com; Korenblit, Miriam Rachel
>> <miriam.rachel.korenblit@intel.com>; johannes@sipsolutions.net;
>> cole@unwrap.rs
>> Subject: [PATCH 2/3] wifi: iwlwifi: mld: fix TSO segmentation explosion when
>> AMSDU is disabled
>>
>> When the TLC notification disables AMSDU for a TID, the MLD driver sets
>> max_tid_amsdu_len to the sentinel value 1. The TSO segmentation path in
>> iwl_mld_tx_tso_segment() checks for zero but not for this sentinel, allowing it to
>> reach the num_subframes calculation:
>>
>>    num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad)
>>                  = (1 + 2) / (1534 + 2) = 0
>>
>> This zero propagates to iwl_tx_tso_segment() which sets:
>>
>>    gso_size = num_subframes * mss = 0
>>
>> Calling skb_gso_segment() with gso_size=0 creates over 32000 tiny segments
>> from a single GSO skb. This floods the TX ring with ~1024 micro-frames (the rest
>> are purged), creating a massive burst of TX completion events that can lead to
>> memory corruption and a subsequent use-after-free in TCP's retransmit queue
>> (refcount underflow in tcp_shifted_skb, NULL deref in tcp_rack_detect_loss).
> 
> And why not fixing this issue?

We have been running with this patch.  It doesn't seem to cause harm,
but also, we still saw at least a few warnings about 32k spins in GSO logic.

I am pretty sure the 32k GSO spin we see is due to some skb memory corruption of some kind,
and I don't know root cause.

Maybe this patch is still worth having, but the description about lots of tx completion events
causing mem corruption seems unfounded to me, and while I have no proof, this sort of
over-confidence in cause vs affect appears similar to some other AI generated patches I've seen.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

