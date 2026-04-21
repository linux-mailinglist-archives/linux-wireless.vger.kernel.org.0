Return-Path: <linux-wireless+bounces-35194-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC6wNzoG6Gl2EQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35194-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:20:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61411440875
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B84F301C8DA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D737B033;
	Tue, 21 Apr 2026 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXDTyjB6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DED35B125
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813624; cv=none; b=E3JoELdPS3U3LVyORudnhsxJh9d34T76WO9DvPi4GgbnauLxm1dCY4Z/fzV7XNYCtNVUHu7jS7iKQXSplFwlT5vTtXdmmCrwIxuuEZSkpSluFw/CfAa2/xYb9Vf6v6DQeroj+xZkOaXdMVEqCSlnOvXDahxOErYBUwaMCPPz4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813624; c=relaxed/simple;
	bh=U5fna9T84Eh3lw8EYGF5YB2t0SNNrEclAefNj5/xlGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpOjz8QFEfNT0Jr6Tz0Uk1NCGqPqhZZ4jK4yA803CO0j7OZ1wB/53fbEiQypdxoELLOAhG+TRjZsAiIpurk88tTxXi+kM8PzD08rkp1P+cgIuUmepn2gWbQV4MtOvF/3CWbwVLBEsd0puZm31v8XyCGlzWrMkSwKb3bKUODsZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nXDTyjB6; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2dedf5f88adso2434988eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776813622; x=1777418422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6iMgIXiaYsvKhx6lPGjL0MHR0FS3/XJAOILK7eE+66w=;
        b=nXDTyjB6nY6fKVdDHZH2aOgXYxIy5CQgD4vlmK9qsDYMI5/qptCGW/AvnNm7GCPU53
         q0ATS2YkAzDte2PG9w6nzKsl3Yn2QdAzS+BLBT03yV64t0IHL6TKjaOorcdSFcmdbtzF
         v/2zvNjPZ2SUJMmhwrlZ8HOj/qnzQyOR63+l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813622; x=1777418422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iMgIXiaYsvKhx6lPGjL0MHR0FS3/XJAOILK7eE+66w=;
        b=VfqLOkjPEDB2U/+JoIirxrAUOsTYv1GbIUuhl3/PIEg4JX05R5ou760wKki3MHnxJP
         KbkIT+cx6rC52NTv7YoQke2V5EDe3X+IHiell4viev4fFUnFbX93CGzUJcTgQ8Pi8jub
         EkbzGAEBZKjNfiLp+mPF3U6NZlvJquLTQK8qwhjyHJQp7mOyZMG08DABO5O+C7a0Tswo
         CPTlVRMDhd4MuaBFmbIyt4f2IylftKzJlHQy6wRE1o2OYfjMoT1MChLRDi++WdHxVrvu
         NoSK8FmvBJ1F3y/Do0GD0s7g/s0zN9to0vkwWB+NW3NnjYMVmr4Ae/l7NKABwpq7xgv3
         ernA==
X-Forwarded-Encrypted: i=1; AFNElJ+5m7Oq+nmhnCOj0xZj9ICtiheguww27mtKibw6idKEqDRSzWHWSRNWSH7NxfvAwg3Su+OiAMuqQS7wUdlg5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVNdVogod3jV3+09bYqezFp5SGkGwaauTBrN5ATj0uIFdt/4x
	1yLM4p2OBX6DDP8H/KNex1FkZPuAM4fCowozkfqDo78MWuBmYSRzQDKHGAicffYIwQ==
X-Gm-Gg: AeBDieu9j2Wc9AKAiVGwMbvFoyP+gYABgdCffB6nwslVtrYp27EQBj1DvYtEmKSHbJB
	hanoKsuN4xMMqjKtzTZH9k+VQ1mOP8YkoSC+Jt71tSha1E0+MXmgnB1SUf8XantXdSjBZaeHORT
	Gd3EKruCJUlKiz2omi+Y95r+/YDaVoKBzIpDBs3PUlt2PJViPNKii47Ht/Q/9jUcp/Sy1uGf7ei
	EHvVgr1lQICzuMH9VOMmq0A3WyIWf7/8D4NVzq7KztJZvOyaL5k1KVti+8BYer4B/5DOG3uobYV
	UdUSmJS6Am5HCPSHFF4+7phhZ1BXvy8nLb+9fcRwtjZcYtM4UiRM7aFsZ8trikD6d7rdYd27tz8
	SkqVOdatx9Rd/JBmZVtEZ/QQbSeEmb21871HRm8wVxBvYRRwUKa4+UMWfTO2vUt726Fk8Dj9RD1
	TI/VYrfyCOOoEHKCIShqg+CePhmQFJ0RzTL6Z6omw0VFMhrerGu1500h4tE73YPL6hhqfebUYm
X-Received: by 2002:a05:7300:8622:b0:2c1:7480:ff9b with SMTP id 5a478bee46e88-2e42e6e99b7mr8746932eec.18.1776813622277;
        Tue, 21 Apr 2026 16:20:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:50be:3375:972d:9e1d])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e539fa5c38sm20402387eec.5.2026.04.21.16.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:20:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:20:20 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 5/6] wifi: mwifiex: fix OOB read from firmware
 intf_num in multichannel event
Message-ID: <aegGNPCYDYqtZB18@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-6-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-6-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35194-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 61411440875
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:49:37PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled intf_num is used to iterate the flexible array
> bss_type_numlist[] without checking it against the TLV data length. An
> inflated value causes out-of-bounds reads past the TLV data.
> 
> Clamp intf_num to the available TLV data.
> 
> Fixes: 8d6b538a5eac ("mwifiex: handle multichannel event")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/marvell/mwifiex/sta_event.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> index fecd88967ceb8..6b7e5b6a66a9e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -450,6 +450,14 @@ void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
>  
>  		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;
>  		intf_num = grp_info->intf_num;
> +		{

I don't think it's typical style to add arbitrary context blocks /
braces just to declare a new variable. It increases the indentation
unnecesarily, for one.

I'd suggest dropping these braces and moving the 'u16 fixed_len;'
declaration up to the top of this block.

> +			u16 fixed_len = sizeof(*grp_info) -
> +					sizeof(grp_info->header);
> +			if (tlv_len < fixed_len ||
> +			    intf_num > tlv_len - fixed_len)

...then there will be less indentation and these line breaks are less
necessary.

Brian

> +				intf_num = 0;
> +		}
> +
>  		for (i = 0; i < intf_num; i++) {
>  			bss_type = grp_info->bss_type_numlist[i] >> 4;
>  			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
> -- 
> 2.47.3
> 

