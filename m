Return-Path: <linux-wireless+bounces-35226-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPYDOfgS6WmBUAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35226-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:27:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83643449B3C
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EAD630022D9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD739E191;
	Wed, 22 Apr 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFup5lW1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B819D08F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882420; cv=none; b=eXjfbOmAKSQLI7IITgeAQdy1NA++MGRhcP3a4joK/BnNnMjLVTimjWVIq+NM2Tni0W9s6YPS2J7dhp6lfGWD3P5ou+mMbnD3taxNNOmuBceC+DkYi3r6d2SFeWgypFLesDq59ihF3KL3V8IgZBP+OCtrWQxE/Xn+I5hOYtlrZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882420; c=relaxed/simple;
	bh=8RergTrTI+oq1eluZtHVRvXF6XK6PJEKkz9ihK4+5ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8Vc6w1JaTExP6fkFIVt+Fg8+iicVpsFJ8MFfa2M2ifopj2qpz5augPB+cy0mEK+Zu2AdMaY7w7nc2UK87SPd3pHVQcLZi4m/UqSiYvAKr5QmxynJPlm9AOaMj3SyaJmlSghH5lsj6PzkYofoOybdEHXPlEfUa9+q7vDo7gXPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nFup5lW1; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so2976490eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776882418; x=1777487218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4f/jhZU0Q8lxdbDfcfDDZ8FwchpeiGu7u1OCYjraWQ=;
        b=nFup5lW1eiwJdXb3oZfhRRZ1kGWnGWuv4ANN7qW9+rW4zwuZFeFXOMFAVBCW+hSqm/
         wpDqgJ4J+bkj6t1qH5/DOggtuqGfjYWkjUGCO2uCjra0V8i3kzVnrdc8gVh+Kk9uMaav
         GSQMG4moHQDspZfDSnOTKXpFiIz5ZfMPi6buU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882418; x=1777487218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4f/jhZU0Q8lxdbDfcfDDZ8FwchpeiGu7u1OCYjraWQ=;
        b=Wvzg4Ahlp9NBJvvl82551fpcbVoGMSs01CCcOEp5i/INQ8VTirKMeaYpmO+3d7fRVW
         fqlEjZrp/s+d9njR4xzixCa8TWBVY1jndRAL+LsW01OVXHJViaHm92GJxeQzJOL/ZGNJ
         UfWLTb2X0XDH9K5QceThJ76eFugUl0/Tw4c+uEfCa+B8AzWA/JR1b8seaW5sBoFf4Gah
         ICLxg75y32oc8LTB2c7fMtjrRoPqiYmxkvp56q+qipOoBJ8/PnKE3kMwSYPlq0fzuO+b
         WvHV2qsfpNMN8XXlifi2avJhIaRaP6sTRwIRN4oUjkb3UOcfor85+5MMKPrpBgd7n+/e
         2RXA==
X-Forwarded-Encrypted: i=1; AFNElJ8ABLPAVfmpfNKeP77RMj1OeVhzNiD+W8ZSpStiXtNRXeFkjELwkfrAt22KGS4WELP7jOpSy+KNKpZ3xTwrQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOl638fE09oKIK+yTZ1nD84Z+R9tKRFaEgD8ANezCQPej7eoTo
	8aIuGXADVfj803MOxWk8b8CWF1JsSS9uvE2chgDVjOC6YPXMEtKlP9ZZa5gnPcBGAGcF+ZHsnV6
	8vXY=
X-Gm-Gg: AeBDiev4XTaSyaD/X8HVYMlE0zxZ1yG/u/VqzQDu9rkXHWX+FeAjUWkY5VNcanwA6tQ
	N8kGi9hXatcm8R4OgO8axljlwABMwyUWVP8RlCMFWMQK/sJeR1G1ndBYz2xdPGTGBzhu6gYMU/u
	ARCxKX4AgjTJHk8gzQwAWAm8P6ig3DGCHmnT1TyZInNqWoSGZZz0CnlolD9OVdaAqxQqrYvOYEE
	uGllt8udjw2crWJ5SfqFuu2LQ+eW8i2hLpBudSBTCPY2D5h8lY0XmJ7BJ3AkOoGBqTmRzsSxF6s
	+ZQEBt8o94ZbTwM331KphbMvkAeP6yG24MNTYNYriyc/Pz+k+9x5zUywJHd0j6Jf5wxs6MTg5SB
	oSJd4Qf+r23rhUr10xnvXn8KzKHp+cF1WEbz3edEz5pxkANDrOAFgGpYHLGvCkvNmijMpk+9Mjr
	JgwnEK1yZkL3Rmr2OxF4c/kVYY786IDrRYkKkEWOkHdYTMcTk660irV7JKlOTTxSQFzyqIDBxy
X-Received: by 2002:a05:693c:300c:b0:2dd:c066:bfe with SMTP id 5a478bee46e88-2e478a331bfmr14869905eec.21.1776882418210;
        Wed, 22 Apr 2026 11:26:58 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e136:eb5d:6ed2:47d5])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e539fa3ce1sm23132837eec.4.2026.04.22.11.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 11:26:57 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:26:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware
 sta_count in station list response
Message-ID: <aekS72ESOUlnqGIo@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-4-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-4-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-35226-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 83643449B3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:49:35PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled sta_count (u16) is used as an unbounded loop
> counter for iterating station info entries. An inflated count drives
> reads past the response buffer into kernel heap memory.
> 
> Add a check that sta_count fits within the response size.
> 
> Fixes: b21783e94e20 ("mwifiex: add sta_list firmware command")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> index 85512f526c5f2..4cf654046c6ae 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
> @@ -976,8 +976,16 @@ static int mwifiex_ret_uap_sta_list(struct mwifiex_private *priv,
>  	struct mwifiex_ie_types_sta_info *sta_info = (void *)&sta_list->tlv;
>  	int i;
>  	struct mwifiex_sta_node *sta_node;
> +	u16 resp_size = le16_to_cpu(resp->size);
> +	u16 count = le16_to_cpu(sta_list->sta_count);
> +	u16 max_count;
>  
> -	for (i = 0; i < (le16_to_cpu(sta_list->sta_count)); i++) {
> +	if (resp_size < sizeof(*resp) - sizeof(resp->params) + sizeof(*sta_list))
> +		return -EINVAL;
> +	max_count = (resp_size - sizeof(*resp) + sizeof(resp->params) -
> +		     sizeof(*sta_list)) / sizeof(*sta_info);

The repeated arithmetic is a bit weird, but I'm not sure if it'd
actually be better to stash it in its own variable. Seems good enough I
suppose.

Acked-by: Brian Norris <briannorris@chromium.org>

> +	count = min(count, max_count);
> +	for (i = 0; i < count; i++) {
>  		sta_node = mwifiex_get_sta_entry(priv, sta_info->mac);
>  		if (unlikely(!sta_node))
>  			continue;
> -- 
> 2.47.3
> 

