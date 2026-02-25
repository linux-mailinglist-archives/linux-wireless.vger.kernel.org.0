Return-Path: <linux-wireless+bounces-32185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAZUAg5hn2lRagQAu9opvQ
	(envelope-from <linux-wireless+bounces-32185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 21:52:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4919D74F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 21:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CCAB3044B5A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3426C3BE;
	Wed, 25 Feb 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFhLEZfi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5021B192
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052747; cv=none; b=cPqIIThpD2UfXCAdi9euUqlIy2vNOzPjdT5i9tNWdkL8FLX74Hjx8x4Pq57d7NqDFqD5b0wn5KBFCZk+kJC1BjZ9P9eZeHL9Tgy8Fr+8Wfe1OeZ7OhU77W+hWN+6zGQlC512Ve/p4ewvj5O+10+N/E7t6YZ46XYW65zPi103EMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052747; c=relaxed/simple;
	bh=dYINiHj1P49kYyhZBbhJZRZRcam9zeCPQdsFAmDttOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUe9NnNst8g3SjyGVCrWRFEHJ58dwxFBNPU9z7S6y5+0kBJwpjebtrj9WoeKqOG/yRmL92OfutWYCQsJ7uBIOhLVHoD8BOu0CWyBrsyZldQCEpOgw0NQECbay4QSZw538I/nJ3GQRVK0JkZ+zhGL1UG/V6V+T0Pwhd/o5mUYgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFhLEZfi; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdc4f2b680so83560eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 12:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772052745; x=1772657545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyOKxPtQV/H/ftMwmWrhiyVIWx/j0l7zmWsJMHaryXE=;
        b=jFhLEZfiL/idQdGuyGMKYFuoW1OJpADzUJyBvUusTdMCmBRVFW+zCZGe/JKK2Llw2x
         pQWqERmHr6LAYYUCklXr4zBjeCwl6QKU/EU7CQ8aWVT9fF2WBl8aKZTlws90psoxvquX
         mDegVlKLGzi9YTQtUCTsp48QoZX8Cder8OQqX8Fyo8J26Fxn0Lp9SMBiiiptKwTeJszb
         WyV0pVEaTlngx9LVf2Hh70s2ijlMz14zH99JCDfGrF+gGn+1kqA12+oVE9aO1d89Cfef
         afU8sszHoCHpUj4HZtXZISZLNbmrWAUWxKiMR50tEOloCp5w1rlFnlD6aOAHUFBGmSdf
         iLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052745; x=1772657545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyOKxPtQV/H/ftMwmWrhiyVIWx/j0l7zmWsJMHaryXE=;
        b=RTtOdUSIYE4ClWWptlZtl4zMd25+pPxQuMufIMCfpV9QFDX5EkFTSMxIx/5W4TaEdQ
         zdCfR78su6/uF0BquPNhq3kTZsSZVfG6yk4TGbhkQkSkmYEY3YK7aowBPMyNFxe8YXmp
         XI3HEBLqWJJImVunW7w+7t5Ua4x0tgOndOCTbVZnOEs/FI9iHSrMsVTWGG/iA5V9xM1/
         nnnY55PDy+TklW63jG/xzHeX3J7s+trfjRmeRbbLIdsdVr6wj2TQOGkKtxBHsHS7rwME
         mZwElAB5dH4dS4MZlYwsDBeWokmnwCQ9ZgTURit/1gonA8yLDyh/bHe6amFc2vRSEOEy
         a7sQ==
X-Gm-Message-State: AOJu0Yy+0Nx26F3mhA/4Kq5ldQ3qWhijKY3m4IH0gcewC9yQMfxUz3Wb
	sKQ+YGCF/Qm/r1Of6mdEFO1+RLwYmzytaqz9nmgkSz1y/+Kh/cUr2ORIU+xSAzBe
X-Gm-Gg: ATEYQzzy5IT/52gzxxuwOgrrQRRegMAZtNJXfph963p8ojbXCH46kDFbzOsX4Ju3MIK
	rp0EfBq4H+HwHpSeKupc6BWnAPB3PQHirokp9cnFJuJ3a/+yZM/P1I7BqRharWlbeuKKWAKGv8D
	SbNT+SEL6aYK/R8GXUnOMoVGvyKdduRkeZMtje9MZL050qtNihWBICO+OX+lX2gdZXbhhKg7xe4
	Jx0s5L+5YxIx3U58oQSrHFukixjWz5Pd8Yajo9pi2fdGnQMUHa7QlL1Ci68xe2TZfmESR2dlvkA
	29itdbBvGa8CrEIqVz7gIPcgL7pUckY/LBGSHpAR2Prd9LMY6JjdYsElD9nUGlNNL/TLM/1VEmi
	wk2BL4Wdeq3pZwriZqB0+Z0uiEhdPzPcKZ0dteK5+b2+1IqWXvWHlNE5/tt4d714eSOyDH4IG4u
	ydZHzOSleB7dTDh6prDXwAUVomsJwBveFHciP8
X-Received: by 2002:a05:693c:2293:b0:2ba:6e6e:d8ef with SMTP id 5a478bee46e88-2bd7bd0a496mr6774686eec.28.1772052744728;
        Wed, 25 Feb 2026 12:52:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bcdd95sm135308eec.6.2026.02.25.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:52:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 25 Feb 2026 12:52:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter =?iso-8859-1?Q?=C5strand?= <astrand@lysator.liu.se>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: ensure skb headroom before skb_push
Message-ID: <1768df30-cac9-4c55-a8bf-1d927d59029c@roeck-us.net>
References: <097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <097bd417-e1d7-acd4-be05-47b199075013@lysator.liu.se>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32185-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liu.se:email]
X-Rspamd-Queue-Id: 6ED4919D74F
X-Rspamd-Action: no action

Hi,

On Wed, Dec 03, 2025 at 08:57:08AM +0100, Peter Åstrand wrote:
> 
> This avoids occasional skb_under_panic Oops from wl1271_tx_work. In this case, headroom is
> less than needed (typically 110 - 94 = 16 bytes).
> 
> Signed-off-by: Peter Astrand <astrand@lysator.liu.se>
> ---
>  drivers/net/wireless/ti/wlcore/tx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
> index f76087be2f75..6241866d39df 100644
> --- a/drivers/net/wireless/ti/wlcore/tx.c
> +++ b/drivers/net/wireless/ti/wlcore/tx.c
> @@ -207,6 +207,11 @@ static int wl1271_tx_allocate(struct wl1271 *wl, struct wl12xx_vif *wlvif,
>  	total_blocks = wlcore_hw_calc_tx_blocks(wl, total_len, spare_blocks);
>  
>  	if (total_blocks <= wl->tx_blocks_available) {
> +		if (skb_headroom(skb) < (total_len - skb->len) &&
> +		    pskb_expand_head(skb, (total_len - skb->len), 0, GFP_ATOMIC)) {
> +			wl1271_free_tx_id(wl, id);
> +			return -EAGAIN;
> +		}

An experimental AI code review agent provided the following feedback:

 If pskb_expand_head() fails, the code returns -EAGAIN. However, in
 wlcore_tx_work_locked(), a return value of -EAGAIN from
 wl1271_prepare_tx_frame() is interpreted as the aggregation buffer being full.
 This causes the code to flush the buffer, put the skb back at the head of the
 queue, and immediately retry the same skb in a tight while loop.

 Because wlcore_tx_work_locked() holds wl->mutex, and the retry happens
 immediately with GFP_ATOMIC, will this result in an infinite loop and a CPU
 soft lockup? Should this return -ENOMEM instead, so the packet is dropped and
 the loop terminates?

I don't understand the code well enough to understand if the AI agent has a
point or not. Please take a look and let me know if this is a real problem.

Thanks,
Guenter

