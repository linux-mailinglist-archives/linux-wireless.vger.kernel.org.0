Return-Path: <linux-wireless+bounces-31543-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYAOp9zg2mFmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31543-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:28:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834BEA34C
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42858300250E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA03426697;
	Wed,  4 Feb 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="gpRxKS5s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB56426691
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221805; cv=none; b=h3y8TM3CBN8PYmCF6k+flRGultVUWfrRPsrFQcTmEPLaWx6NSkiKPDRl2eTe9gQlQHHxa7KSS9OXM9TqBbjBG5P7x+T5KV0r/YbeqiqaQDaBbPJ/QzLueV+j/s7LKCogaXDaQJU1w49EDCF1KRaXWnK2ynJJSEdcNhVe4BHfD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221805; c=relaxed/simple;
	bh=zm024foQnr+cO2k7NwJZtgughK/BhjVMaT1Jv/2BCMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuxWc3CBEt5FuNmDkoDeK7R1AKump68pYnSOeem/Q1RBf4+8VQ+PYtgZgjl9dg+1kXFByV/1oBX7tXLGLvl2t57fZy/b8taq/gvUiAXi0HxEI/j6xZdRZUPPSiVEcAqFdnllQXyu+b7Pgyyzy0colSktp+qP/xGC8Q8go1t/iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=gpRxKS5s; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 65297506E58
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 16:16:38 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 23815800D5;
	Wed,  4 Feb 2026 16:16:30 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 8513E13C2B0;
	Wed,  4 Feb 2026 08:16:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8513E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1770221787;
	bh=zm024foQnr+cO2k7NwJZtgughK/BhjVMaT1Jv/2BCMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gpRxKS5scg7jp2UORIN3o8go1R1qZ8P5CMTnq4b8hwGKx7gBCHiL1h2+tfSATQrmz
	 I5OaHeS1nrK2ePVo92tWIQlSLy2DZIWkkYLMZgHgnjrIMU3LOoz88HwSJ5iuXbk6pg
	 b+Nnv6qE5fxFJNlhcCzqswf0qJepKYOaOt1hFqw0=
Message-ID: <3f808803-f183-df1d-8a7f-e57778ab4a68@candelatech.com>
Date: Wed, 4 Feb 2026 08:16:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi: Null deref in iwl_mld_reorder
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <ed9ab029-a762-4666-85ed-7a67ec7c1b52@candelatech.com>
 <da71512c862e91e6394184f2b6c39dba009a87b2.camel@sipsolutions.net>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <da71512c862e91e6394184f2b6c39dba009a87b2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1770221791-c9cCOX1SVrNL
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1770221791;c9cCOX1SVrNL;<greearb@candelatech.com>;2c88245ac2c359a50cba589b811aa232
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31543-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,candelatech.com:dkim,candelatech.com:email,candelatech.com:url,candelatech.com:mid]
X-Rspamd-Queue-Id: 0834BEA34C
X-Rspamd-Action: no action

On 2/4/26 07:32, Johannes Berg wrote:
> On Wed, 2026-02-04 at 05:41 -0800, Ben Greear wrote:
>>
>> I guess the compiler optimized this somehow so that crashes are not actually
>> seen in this particular code path.  Also possible that it is somehow exacerbated
>> by some local patch in our tree.
>>
>> But, probably best to assign mld_sta after the NULL sta check.
> 
> Admittedly not great, but
> 
>>           struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
> 
> That's just a pointer calculation, ie. mld_sta = sta + offset, so
> there's no actual dereference.

Ok, thanks for reviewing.

--Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



