Return-Path: <linux-wireless+bounces-35193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KcaE0YH6Gl2EQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:24:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D90F94408FD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E04DC30CD559
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6306F38422F;
	Tue, 21 Apr 2026 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHj+p4rk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61035B125
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813600; cv=none; b=FZ02jCJFbGCTKQTJJxb9n7I2Ig/4rSebkn/UY+OnrKjuBhTg/4L35OOJn/HrXS0VKDXIrRiehozpPxKUE/xom2Y+JnCcQfj0FDzXoW/484GUKZNGA98+ddCWAwvv9KM0xej8IT3+nipX3x2TMfT7bWyTscxOlRJwyvr4k5D//DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813600; c=relaxed/simple;
	bh=JF0pfV10el+BIQPxfGUcn9naLlXjpzu7YwZ02CBt5x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8LOuDr3w8AoBTo5DtOd0wrB+84pBKXmoCIedyGZFc+RsFy+9SotO2EOdlz+wLTwilSiA041u2IYmhT98qQcsvHlSx/wlLhvAYd2QBKHYazHCZWplTHHvvg6eC6ikGYQW7AZ9C7KKLXM2J7kJFWOGF2GhMBYlDxyYlzFcTBj8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHj+p4rk; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3778677eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776813598; x=1777418398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDAwolGhmd8ezhA2m7bs+zUqsnY6mZZ3Eo2Y+ZzzqVY=;
        b=WHj+p4rkebwu94pUqTLkVdD66XpTVXIGgI+9+Ms0hbURa1QJOqFqz+G0pxcW1DX/YK
         VmE5JeoLCuk1pwhmoLwHJ1WJVYyBdbacnxMcmyhYUX+WKKJufyag+dlvVeMP39XOyWhi
         7WeEiYE2sgLUP84gT+apgmpn0bEkkGYD9g45Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813598; x=1777418398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDAwolGhmd8ezhA2m7bs+zUqsnY6mZZ3Eo2Y+ZzzqVY=;
        b=aawRqrTRi9+rG8YKvnymAuGwAn+f/V45Byqkz8mSJdwQwn4Wg4+9jgOTymsgUYVBI8
         q/WHOcNmgY40fSeVMs3LI09f1BtkLqVvL0FGFkZGfIStcz6UUDQPIdK4eA9K1G2+ma/a
         s5x0wggI8qreh/WGAHrfMGHfJHqfATHHI6rpWcI607mlWP7z8g6vlSVt/cwOHS8P+PdU
         XMbKuZg/98FIHEafCMHcAVmSOpe9qCboKXFgINke3u/SMDEXYiXW1/9gWS25+Vqzi2tK
         Axq/HYA2/25DICiI/VG3gQGW2UKb4+YZMO9C7OnqRTP8/rk+7+tW4cSnuoo95ScNUC/O
         ZshQ==
X-Forwarded-Encrypted: i=1; AFNElJ9x6zJM9Pv4jjq5Nt9Out3slASq/XzMCYuz9NsFdDSi/XzscaHMtOLjwtdJzhXm00wQQ6PGH5ZfV5r6i0XIAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE7ivrH8ntsWR6InkJjBvSyRCVw9q3UQZ5HAwD+dvRbHkQd435
	HJVyGGtDzvqn5YKkukPpagY7o4Q3iydHG4zl7qRkTMJElLebeYFyHr1XaCXIetmo9A==
X-Gm-Gg: AeBDietFls75xGmQN4oJBMG4rEvg/fpVNOd/4dp5SI7kOc74PCztulnJBezr+8Y00KJ
	OthMN5kLuQ8V3kKhn/PQbGf0bdux/FMk5DbsUe5o3LLDqoqMhuAT7ssNdQTp9U+otH1tB50+6Hm
	FGdmxr4fwgCu31BweAA3GeJ3zYaRsNsFkiivOJ1jn+4pPzV8KNF/Vpo099BRY8yu7n/t9uRPNdP
	hCf0Q6aRUPumo2+KTtNBL+E/6asNem0uzsbjUbrW4iZsL4UIgbBrChLa3fHqv0ujxN0nbzIBEF5
	B2R2ppZ2xEo3lD2dWNLy70DakxUEsbjeSsc1iKhRmhVsBVU4291l/aHv7+5mv5C/YiwByUy6eSA
	fXi1Ii1JbirIaBu55t1oqtghMPidyav6VX5uEfkDVzmGPFQGOU4kHcNP0b8dQvOXrhVmQn93a7V
	gmKfjf7/0S5PJ19KGwbrANM4khVd+OjXt1xdDOU9jYnZqOiQr01oRhfVF6AV53WqRRxUtoCOh8
X-Received: by 2002:a05:7300:2203:b0:2d9:7bc4:9578 with SMTP id 5a478bee46e88-2e47951a762mr14662626eec.28.1776813597960;
        Tue, 21 Apr 2026 16:19:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:50be:3375:972d:9e1d])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e53ccce460sm21565287eec.19.2026.04.21.16.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:19:57 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:19:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 1/6] wifi: mwifiex: fix OOB write from firmware
 queue_index in WMM status response
Message-ID: <aegGG-lGJZqbvPdJ@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-2-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-2-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35193-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D90F94408FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

I haven't gotten through all of these yet, but so far, they seem good
aside from some cosmetic things.

Comments inline.

On Tue, Apr 21, 2026 at 01:49:33PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The firmware-controlled queue_index (u8) from the WMM queue status TLV
> is used to index the 4-entry ac_status[] array without validation. An
> out-of-range value causes out-of-bounds writes of three firmware-
> controlled bytes into adjacent struct fields.
> 
> Add a bounds check before using queue_index as an array index.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/marvell/mwifiex/wmm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
> index 841505e83c7fd..27e6dedcca2e8 100644
> --- a/drivers/net/wireless/marvell/mwifiex/wmm.c
> +++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
> @@ -943,6 +943,11 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
>  				    tlv_wmm_qstatus->flow_required,
>  				    tlv_wmm_qstatus->disabled);
>  
> +

Checkpatch complains about these double blank lines. Remove one.

> +			if (tlv_wmm_qstatus->queue_index >=
> +			    IEEE80211_NUM_ACS) {

Unnecessary line break.

You could also replace IEEE80211_NUM_ACS with
ARRAY_SIZE(priv->wmm.ac_status) for clarity.

> +				break;
> +			}

Might as well drop the braces, for a simple 1-liner conditional.

Also, please add a blank line after.

Thanks,
Brian

>  			ac_status = &priv->wmm.ac_status[tlv_wmm_qstatus->
>  							 queue_index];
>  			ac_status->disabled = tlv_wmm_qstatus->disabled;
> -- 
> 2.47.3
> 

