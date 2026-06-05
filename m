Return-Path: <linux-wireless+bounces-37400-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcafFJgrImrJTQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37400-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 03:51:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4EE644888
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 03:51:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=hmDSQCHf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37400-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37400-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0294E310926F
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42AF38B15E;
	Fri,  5 Jun 2026 01:37:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45393D25C6
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 01:37:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623438; cv=none; b=PzSKKUXYOrMZ9mBGPCRFjfFJ+W+xNGOiBWMzELpwpv1c7lNaYaG87dNu/ug+OxOceFKOTRxAx0N0qIQZ0ybIS+UHeBHZfV9SbmEl6FcvzKbrcbmziwofeU3NB/S8iMg3058g0C7l9UoCnhiWR5sX6+PzuH+F/WEOPaazXctxuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623438; c=relaxed/simple;
	bh=p0gghpvPD3+GfjmZjN3CHuee0D96vimcY4fMbwhUbeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egL0HT7DkMSktOgrMxvmTACy2IyncoFW6qnpMXZkgsbsk2a263Bz75+xIaE1820TtM+6FnPbpSRa3kyC5qI5acjXijQCOditaxuEuyxPwALVrsAN4aagQ4Ux3NHhj/8WPGKTeWuu+6hrxK2L9l0ge2W2xPiDa9L6ilq6bxuzH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=hmDSQCHf; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so749938b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780623432; x=1781228232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3YJVB0X+wOpRvyKCo/LAB/oLyFtsEoBhz1pZ3Gryj0=;
        b=hmDSQCHfmJnTpH6Ba7UzGxNVsxjufARIlPVerFLM6lM3nHQQJ6hFdjYktwU7D/9Ota
         GeEUXiFMpDvND6Wge5i3lmL7hPH4Yyg1cEiMbfnj4JdYe7Cam09ZrOLB3GPJLR0ypdQM
         g0Mmx8RWoVa8GlvOl3c9bBbPWoMZXL4mZDn8H4ZzzfZutaTg86CuDDeHmFUV2Fq3erbv
         WKMQp7mkZuER1aW9Bq9NdMXrBdNCAIEY10NONXTj8vQ6mVhzvJ16jsmVUDVGhSObHGU/
         iH0Vr6x+4Ysjro3bs4x6trdrTm7t+rU5Um6SpOIOJmQnMOt0tfnawQqbdLYGJkiDd7Qx
         T8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780623432; x=1781228232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3YJVB0X+wOpRvyKCo/LAB/oLyFtsEoBhz1pZ3Gryj0=;
        b=rNyYJzdZeNgMTnyXFCZ3OGhWR7hiHaIVum7J+onaCZl6udVH+4/QNENYetwZDHqMST
         wnRHk5HfrZlzkUzhsAEhDQzuKfQrI4yLHjwsh6F8ZByM6yyNPrHGPGm7HgobPRise59B
         3TpyFOoA+qoEJNcxgVqWZOyZbOFqEclLLFkYWElSL5c5Tn8JVl9aLnLrLryFoNEQd8lW
         4nKvpvtlpljtApYBeAvWtGTOJUOl2sjLFD8WE1eFT+lYW4tR5lAHr7TrqnQG3HsXDq0A
         J9iHhGMiegsKIIhAoGXLXuDSmAgWReommWJ0wYwtvCkpqukUnJ8pD4/gLSXeDmbYeqIS
         cZ+A==
X-Forwarded-Encrypted: i=1; AFNElJ+DGvwj5CStSAWVzv4CcoTwBXHKTts6RKeEqBd1UwWqB9YXIAbZg/5jrFNmqdsqkpZ1mPl+/6j0LxEUdsVdjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSC2a40dUhLNsXjYteN/Mahpni4YEci+qfC5CJhySRcgdiUIr3
	YEchfI2mTNkQegAhynFEHeGKG0YHYV0VdLpfe33Su289IET4bMU14wRJpJJTu972g5I=
X-Gm-Gg: Acq92OEt9/I4Nhob0Mdk9F02cyO9yjKzAABX46QBVIg2zkCmaRzEp9F2hUxUUZF+cSB
	5Y8QCmEy7hMWmMCLIrqWgVvYIhO4TLJvixftAQV2a+ZmoTIkI6z2c2K1wQRMRhR+WS4AFyehYeS
	oLrASkQ+J4RAcQpHk27Wj952mDaG1Wn0L3vMy+QqCisEor365ZFQgxn2mIwolrNMaTKczhAYGoN
	ozqxnPjspXzpy+qPGchyy+0pYn9RW7l7fIJNem6S9nmLCVfZwxRtickWTb0H+Q8bCly3z37i2L3
	IrQdAEsDzuDbKSVQbN4aTDiBtCFcZRvtpBEioIje1AFSy61eGFjCIzQeP8ovwX07EgarDYrZCgk
	vs+EgTKxGZR8DxFzLo/bCf36VpCHn7siohCwEkL3NDtUo7qJnNraOSXOUzL071aLTorpfA0GQiz
	K2u8pPAHPTBE0KP8IypibrAccCvRw7G5KV6R5x5mE7XfQvr4Y/Li9Tt+6b+s46mcY9mtjIKxn1k
	oQkUUozLq+hQYe5KieFGpzMNv/Cnzmi0Kicregs5J+7
X-Received: by 2002:a05:6a00:418d:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-842b0e1fd5fmr1106286b3a.4.1780623431696;
        Thu, 04 Jun 2026 18:37:11 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm9107777b3a.61.2026.06.04.18.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 18:37:11 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:36:58 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Arien Judge <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH wireless-next v2 12/31] wifi: mm81x: add mac.c
Message-ID: <melvfwusxqypnswfhlapfi2w2awyw6zyc4lkvi6t4sog5njvb5@d7qyhc23sgaj>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
 <20260430045615.334669-13-lachlan.hodges@morsemicro.com>
 <e964f5728bde677dc837f55617a83b63c364cbf3.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e964f5728bde677dc837f55617a83b63c364cbf3.camel@sipsolutions.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37400-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[morsemicro.com,kernel.org,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,d7qyhc23sgaj:mid,vger.kernel.org:from_smtp,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC4EE644888

On Thu, Jun 04, 2026 at 01:46:32PM +0200, Johannes Berg wrote:
> 
> > +static void mm81x_mac_ops_flush(struct ieee80211_hw *hw,
> > +				struct ieee80211_vif *vif, u32 queues,
> > +				bool drop)
> > +{
> > +	struct mm81x *mors = hw->priv;
> > +
> > +	/* We don't support IEEE80211_HW_QUEUE_CONTROL so flush all queues */
> > +	if (drop) {
> > +		/*
> > +		 * No need to call mm81x_skbq_stop_tx_queues as mac80211
> > +		 * has already cancelled each queue prior to calling .flush()
> > +		 */
> > +		mm81x_skbq_data_traffic_pause(mors);
> > +
> > +		flush_work(&mors->hif_work);
> > +		flush_work(&mors->tx_stale_work);
> > +
> > +		mm81x_hif_clear_events(mors);
> > +		mm81x_hif_flush_tx_data(mors);
> > +		mm81x_hif_flush_cmds(mors);
> > +
> > +		/* Reenable data, not that there will be any */
> > +		mm81x_skbq_data_traffic_resume(mors);
> > +	}
> > +}
> 
> Doing nothing in the !drop case seems questionable - mac80211 uses this
> sometimes to e.g. make sure a deauth frame really went out before
> shutting down the hardware.

Yea I agree, we should handle both cases it looks like need to
rework some of the hw queue logic such that we can handle the !drop
case.

> > +static void mm81x_mac_ops_sta_rc_update(struct ieee80211_hw *hw,
> > +					struct ieee80211_vif *vif,
> > +					struct ieee80211_link_sta *link_sta,
> > +					u32 changed)
> > +{
> > +	struct mm81x *mors = hw->priv;
> > +	struct ieee80211_sta *sta = link_sta->sta;
> > +	enum ieee80211_sta_state old_state;
> > +	enum ieee80211_sta_state new_state;
> > +
> > +	dev_dbg(mors->dev,
> > +		"Rate control config updated (changed %u, peer address %pM)",
> > +		changed, sta->addr);
> > +
> > +	if (!(changed & IEEE80211_RC_BW_CHANGED))
> > +		return;
> > +
> > +	/*
> > +	 * Simulate the disconnection and connection to reinitialize the sta
> > +	 * in mmrc with new BW
> > +	 */
> > +	old_state = IEEE80211_STA_ASSOC;
> > +	new_state = IEEE80211_STA_NOTEXIST;
> 
> No real objection since it's driver internal, but note that this
> transition is normally impossible from mac80211 since it doesn't go
> through the intermediate states.

I realised not too long ago that this function can be entirely removed
since this path is not possible in the current S1G implementation,
atleast until channel switching is implemented but compared to
regular wifi I don't think it's as important to have. So I'm just
going to remove it for v3.

lachlan

