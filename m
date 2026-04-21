Return-Path: <linux-wireless+bounces-35195-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PTHKGYH6GnSEQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35195-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:25:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BF440916
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419763011BF1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77337B033;
	Tue, 21 Apr 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isRvEKrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80735175A6B
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813648; cv=none; b=SpUkr2f5kL6MA4daTA/8I/hARhTvMbusbDfLrfX9YWgoM2nu+vwGBiCQe3d9J8ZRr4HHBZN2OmNJ226tQWyFe1xuJKbLZxW784PU0GTyDES5wbjDKu9Mz7IKyt6x6vXQ6Q/VObTGCVJBtG1i40yKo5jZUUJkE5SimJJcEayRN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813648; c=relaxed/simple;
	bh=9ZgTulgUxhvZKYV+IyQkhLacbnd+Kv+iVY9zqeCHwe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2kkZPRvQGGVR20U2XA9phNCnbuCX1spRNa7FiJBRgt0I1Vd3qdisCq0cXVsM0TrAIMhyjRpa4Wf5eLsnKCTQhAAvlpscUGUEHbw446WYlYviCEul51OfBgkneCPRcHXIJ5TkY0hrhwpaa2lB4CJHrSk7QtAyVu/lfxxyNb5mUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=isRvEKrq; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so6237398eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776813647; x=1777418447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWdqTOPPJRY7AERUG5LWnOvgVQGh1E6y6TFFrS2MBo0=;
        b=isRvEKrqZgmNyeOedbeeDSaYyGlDYEWy38dy7a01ALZ7bqqk+PKS0ydl1Izi879/OO
         bPwMPVd0T/Sl8pGMosr+ZClrUmkugnOQ66kKkGvVhOP2ZcS7w0XNzrxEYKSxEAnsQTrP
         SIm+EFiXM8w4ya1Ak5o30a3fy+RuKoUeTZMrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813647; x=1777418447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWdqTOPPJRY7AERUG5LWnOvgVQGh1E6y6TFFrS2MBo0=;
        b=W4OtdTdaAk2oKjTy2AWWMCtn9VuAsZc3uxR4NWlZGcsOIKe6nWAzQn/a9WUl31ovSN
         /KqiXhEHgmYuWGIC8RC/eNUzyuyhD/mqilXmjbrUecu4QJIy1gZF5IBqIYe5trEo9ZDn
         ExxRTihE2E+Qkb9ugqz5/Slbok09d5Vx5DHoXJVCkuBdxkt52+mFLwvmYZHrxvyGogla
         w6KCYzuwxNVTU3kueNgUI1ixU7mOr71mPLJFHIIgWhQA91HGZVay4Rh8xWD+CFsz6SSe
         dNNqTtRlJ7Fq4CKboyeiexhbbkXq2zGCZUYxbFNDZI9YfA1AoiHYSM0KEqeSAuTMPo/H
         JgLg==
X-Forwarded-Encrypted: i=1; AFNElJ98VLQX00mr3z+1DuUh6A8k/9VdM8Obu2fXrnNhwaWCVQFybHAJTeRCpk6VInEzs+jOaCdg0wvbldDoryTUuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wmUYb9QyZoloWuZNA25B+NOsAfQdOf1iKBhJaWi4XUo+V3J2
	cav8KiJP5pbWiw+qbAFKlppuQO4/VbLHvL6BvehS+MrnE/MX+tzZH9bYHa4Pj2attg==
X-Gm-Gg: AeBDietas+p2PZAL37yj6po8kNMKCTHNcE8IeDa4mP8Q5pDXagKx0getQXae+I/CytB
	yJ+c9J/d5vTAm5fNi81PyacrckD9aDZEhfV5dl3hRf8KC4NSUF86GD04GhqI58i/HmKEpUVDVzg
	XNYV4THKndEzKjKJT70yYGbJbG7aHzkZ/9y/x4wdZ622HLNwVnh03iN2/o44h5euB2FhGXetLjk
	GDFsbjRbDdk26R+gYltEiv9l4IcxXKdn+h40jmL+t3Zs4dQ6pxN83lhFgfI29jYRd8sqRXPrFB0
	lLD2lu5VVrXXHNKDWZmdxoDCnBBG2piUhg/Y+TRkXHnT105Cah9xlnDHdh6x7zIpSr8qPBo8G/J
	kqBLYOMO4W+qg1vHXC8yaRL5J6Uip3UoZL0MLlrrC2HWUyJqmRSwA6DzwDNyqZfAcs5Pyqtp2wD
	gBt5tQFgVGrmILf6RGmY+VccYFc0JqT5NsEibRUAQCHhlswB2aVuedc2kV9VqW1jqybP5nlckE
X-Received: by 2002:a05:693c:2c0d:b0:2c8:7172:3b88 with SMTP id 5a478bee46e88-2e47930be3cmr12408387eec.28.1776813646689;
        Tue, 21 Apr 2026 16:20:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:50be:3375:972d:9e1d])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e539fa244csm20302766eec.2.2026.04.21.16.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:20:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:20:44 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 6/6] wifi: mwifiex: fix OOB read from inflated TLV
 length in IBSS peer event
Message-ID: <aegGTEs4zK-hpf9c@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-7-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-7-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35195-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 0C2BF440916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

On Tue, Apr 21, 2026 at 01:49:38PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The IBSS connected handler replaces the buffer-bounded evt_len with
> the firmware-controlled TLV header length. An inflated value drives the
> IE parsing loop past the event buffer into adjacent kernel heap memory.
> 
> Cap the TLV-derived length at the remaining event data size.
> 
> Fixes: 432da7d243da ("mwifiex: add HT aggregation support for adhoc mode")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/marvell/mwifiex/sta_event.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_event.c b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> index 6b7e5b6a66a9e..62a879c09106e 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_event.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_event.c
> @@ -45,6 +45,10 @@ static int mwifiex_check_ibss_peer_capabilities(struct mwifiex_private *priv,
>  		 */
>  		evt_len = le16_to_cpu(tlv_mgmt_frame->header.len);
>  		curr += (sizeof(*tlv_mgmt_frame) + 12);
> +		if (evt_len > event->len -
> +		    (curr - event->data))
> +			evt_len = event->len -
> +				  (curr - event->data);

The above 4 line have excessive line breaks. You're not even close to 80
characters (the old-school line limit), let alone the more modern 100
limit that checkpatch uses.

Just make this 2 unbroken lines:

		if (condition)
			evt_len = ...;

Brian

>  	} else {
>  		mwifiex_dbg(priv->adapter, MSG,
>  			    "management frame tlv not found!\n");
> -- 
> 2.47.3
> 

