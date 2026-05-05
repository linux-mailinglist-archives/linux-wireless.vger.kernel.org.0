Return-Path: <linux-wireless+bounces-35911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Nv5HbP/+WljHAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:33:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B654CF787
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08ABD30B55DE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF07426EC5;
	Tue,  5 May 2026 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="fQablhc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2C2DCF57
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991154; cv=none; b=UQn6mXhn8pWCnWaoOmSFJWW1mcig0EyktaFVjl0i1AJjp7kMcerJ4e/UDYoXVXkv2NIeWags/okfKjdw7bSiDO1uzuVUrf1TAPt4x6LWB0s2Fd/cNY5RW3T3y2c9dUmUL21nDObNY7c9dapxDkEup1QNbdG7gCjmaqWFbaS4gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991154; c=relaxed/simple;
	bh=4haBLKqU+/5tSezjdlucRMwNLws2PrcfnL48ooJu6Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVEPAO74YFsVCqoOTmG1BLpUGHVK51Da3WjEwu7UpmUJAJ94EIZbrSZnfZY91k8wH2uoSmMH0icMBj6mC3NPxup3G7Frvisp/l2GyWWgohBUe0874JlZgvR6ZtwRNrm3BXJDpXZOa5x6Csdf/8fhXbC4VLNKX+H7eAgxE3sObGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=fQablhc2; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 568812A5499
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:17:37 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3A37D240077;
	Tue,  5 May 2026 14:17:28 +0000 (UTC)
Received: from [192.168.1.23] (unknown [98.97.37.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DC4E013C2B0;
	Tue,  5 May 2026 07:17:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DC4E013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1777990645;
	bh=4haBLKqU+/5tSezjdlucRMwNLws2PrcfnL48ooJu6Wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fQablhc2f6RsIQCKZXBizIaNH1KNYB44ba3mruc2G5Imcd5UYR316zdqyPAAt1jAI
	 HvOzHiEl9N1d8aGHQlpliFlm8FUEIMDQr2AoDUQWxFE+Lq7GLcrI1J8p1Kyn59edWS
	 WBxPG7aYy8OZ8AY0kKJ6MlozFO5UH32qFBn/TA3A=
Message-ID: <d50bc7a2-352d-43ff-b3c7-b5b13ce7112b@candelatech.com>
Date: Tue, 5 May 2026 07:17:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: check stations are removed
 before MLD change
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260505151731.3d7cbb8b952c.I4ce7b536e8af26d7b115e82fd733734446cc56a4@changeid>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20260505151731.3d7cbb8b952c.I4ce7b536e8af26d7b115e82fd733734446cc56a4@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1777990649-FsS5FD4AwieG
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1777990649;FsS5FD4AwieG;<greearb@candelatech.com>;f1d04f72c2073390392d60b6e12a1708
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: D8B654CF787
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35911-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,candelatech.com:mid,candelatech.com:email,candelatech.com:dkim,candelatech.com:url]

On 5/5/26 06:17, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If an interface changes to/from MLD, then all stations related
> to it must have been removed first. This is just natural since
> we go from having links to not (or vice versa), but not doing
> so also causes crashes in debugfs since vif changing to/from
> MLD removes the entire debugfs for the vif, including stations.
> 
> Delete all stations but warn in this case, other code should
> be handling it, in effect fail fast rather than doing a double
> free or use-after-free in debugfs.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> This basically makes sure that the bug I fixed in
> https://lore.kernel.org/linux-wireless/20260505151533.c4e52deb06ad.Iafe56cec7de8512626169496b134bce3a6c17010@changeid/
> is noticed quickly. I'll probably merge this only
> after the fix lands in wireless-next via net/net-next.
> ---
>   net/mac80211/link.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/link.c b/net/mac80211/link.c
> index 93e290dd783f..e81dd02de12e 100644
> --- a/net/mac80211/link.c
> +++ b/net/mac80211/link.c
> @@ -2,7 +2,7 @@
>   /*
>    * MLO link handling
>    *
> - * Copyright (C) 2022-2025 Intel Corporation
> + * Copyright (C) 2022-2026 Intel Corporation
>    */
>   #include <linux/slab.h>
>   #include <linux/kernel.h>
> @@ -307,6 +307,9 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
>   	if (old_links == new_links && dormant_links == sdata->vif.dormant_links)
>   		return 0;
>   
> +	if (!old_links || !new_links)
> +		WARN_ON(sta_info_flush(sdata, -1) > 0);

Maybe WARN_ON_ONCE to keep log spam to a minimum?

Thanks,
Ben

> +
>   	/* if there were no old links, need to clear the pointers to deflink */
>   	if (!old_links)
>   		rem |= BIT(0);

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


