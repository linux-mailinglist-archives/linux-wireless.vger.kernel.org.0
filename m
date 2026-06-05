Return-Path: <linux-wireless+bounces-37405-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqwoDoptImpQXAEAu9opvQ
	(envelope-from <linux-wireless+bounces-37405-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 08:32:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2F645875
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 08:32:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=Uz3HAf06;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37405-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37405-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7826306570A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 06:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80310403E93;
	Fri,  5 Jun 2026 06:26:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2208405C37
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 06:26:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640792; cv=none; b=ZIs8c0y27OxBbsAzUkoSOF6ziGrpNbj79R9ySbKbl+dOjofUuWMeDQX63lB4iomp/p13ucKLtZg2kBST0Zk45DD/4NVNRvd4U4tUvCaQQbYVtfRyuPL3jXTXCeb+nV8t5zG7Fov6oJ3tr38bCEblJRPoXuf0kyhQw1++WfavLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640792; c=relaxed/simple;
	bh=iNh/mb2eiocXb4S+1yThHgdvvhY1IocXV2BZgTAkwK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT1DXEB/rdlbPtpfEAvKCo2z+0dTG0sfVhXbhgESbSyVaTq/vYAoowWRqDQAe/7g+jJQKcNiti/dYuvVTPz/sAKxCi4oFAHb2mbdho4feUOXjqOQauCbMi5tyyzRRTfsr4DzAnWtH564lN3fKj3sINPw0946MAUhczoQqxPnHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=Uz3HAf06; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso10954945ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jun 2026 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780640790; x=1781245590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3Fr+w0Wf3CCQXoGfTaQ02R3tpfIPjjorzQJs8m1zi4=;
        b=Uz3HAf06x0tALnIibZfkTSNE9qTfiQNPzZy9pdw1V5DdazXa9dlr0d48rg9vY08XwK
         qUmRPZTpLXnipL/U7QGiaYPMnS9f0Rijn6fC9E6LURTbbQc66nbs9qzT4yPGHLhnriKp
         MSpMiRh33K7pwQGeRwY+peY1tYiMtz+wei7iePl1jC32M9WriyTcYnO8VOLlUJwzW0Nr
         ebzC7tv0lysrafPiFnZOVTeYGI07YT5VfDM45qntpPKAhPqbgOvdGbCLGCpKg2n2P8Ad
         3J5MrHCGqA/O+rFIlygL9W8ojrlnYkZYd1C51ZH06zKQkzErLUEKA5Fo9S7O0ahNJamk
         Dkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780640790; x=1781245590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3Fr+w0Wf3CCQXoGfTaQ02R3tpfIPjjorzQJs8m1zi4=;
        b=jumBMyH3+jBklPO4k3aNhJCdQenCpfySS0SjFcwdCkEvCLe4/0dXYePSoRTi1E1qDk
         P1dD96MNa1CSzkZ7wa/yE0J6Eil6LAU+rL5tQpI4cfly4YiduDvNCHIicK1RGESXo2E1
         VddsqPAOR0bnAKB/8QDdUD/vNVX/KhQTc41K7+iR6b/pHgLwfcziVqIHYFoBAtT0G+MQ
         GreXKLrUfWfhNNVfmRhiyNAA8WdvN0VRHfqgvdgm7yt0xGZnIgknlBmSt/z0eM2MDDKz
         r0Pyi97Dfp9d/p6Gb9xFodACd2vFVxaoH8l+CYZtG2FHIH1X6Je90RInIYlOPnIYapUg
         8xQA==
X-Forwarded-Encrypted: i=1; AFNElJ87V+0vmg38odHFUuFmp/HnsffTW1mBKBbnnfTRR39mreihHwfF/0CrrGwSnd4cfQBr33h5TMwGZo4TolsdhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDTanhCkP/bdyqnv/A/xaQ1cZS686R15PvROrSBe9VM5hK0iw
	iQPyOZXJ5mGNbfc0u06ZrFMfA9CByD61vV3Vwkd0OGlUPBzmRrQr+dVMbq80o00iq0c=
X-Gm-Gg: Acq92OFiQ/XBAPlBHzb4RgpZch2Iwg38mAYtFxYFdN8Yn0k0Qh9GjdanGPB6Hx3jpZ2
	fMCTStZYDdoujdu9ftMeAA6Nkjod3/zZk6wHwlQK7fYdLNWa9NARZo3hQXUGfQtt+i9lZYkhE5J
	PKOZKgHfumGz4fbjRpwUdIW0N+ECWUpkh1FmSAvhqieCuiCLRS1pqLapHt/aFOwV1BqwWz/gbOC
	LyS6svQ5AWi89HHogdD42vpKCkaiWjBG0h14+JrhN9ry1ZEbPE9F8xliDia5LIS299ZW1WkYACg
	+bAfC/J33Ri8+cWpq0aRVgoPZAqMOuWUsJIAgSdnrNbMhn/b4kwxTASVmOFi20O5/SHfTt6qHRz
	afWo22h4/Uohhs7ry2VFURG2urhFMZm2uKZ0TvXPgiG4qVOaz87Pb91ydkFJwr3i+Fmzrzfbn2l
	Zbo0EavvG62SSlNNMWnb4Cq/ObQS1C28d9X/BBeZoo/IweUOHM52ak5w979CjqM7ZxUnSWWDm3g
	KDeYFUja9OckXof/i3p43ToRY1c21GAeQ==
X-Received: by 2002:a17:902:ecc3:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1e8339808mr21810535ad.33.1780640790120;
        Thu, 04 Jun 2026 23:26:30 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cf89sm78782835ad.56.2026.06.04.23.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:26:29 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:26:24 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dan Callaghan <dan.callaghan@morsemicro.com>, 
	Arien Judge <arien.judge@morsemicro.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH wireless-next v2 12/31] wifi: mm81x: add mac.c
Message-ID: <aqbfc2k7xdlggjchxuuklzliuu7cutoqwemjc72zrghhrvwf5f@gqnz7wyqirxx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37405-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gqnz7wyqirxx:mid,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FF2F645875

Hi Johannes, just having a think about how to do this:

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

What is the consensus (or I guess your opinion) on using
read_poll_timeout() with a function that isn't really doing any real
I/O but rather just reading software queue state? E.g.:

static void mm81x_mac_wait_queues(struct mm81x *mors)
{
	int remaining;

	if (read_poll_timeout(mm81x_hif_get_tx_outstanding_count, remaining,
			      !remaining, MM81X_FLUSH_DRAIN_POLL_US,
			      MM81X_FLUSH_DRAIN_TIMEOUT_US, false, mors))
		dev_warn(mors->dev,
			 "Unable to empty queues before timeout. Remaining: %d",
			 remaining);
}

where mm81x_hif_get_tx_outstanding_count internally is:

int mm81x_yaps_get_tx_outstanding_count(struct mm81x *mors)
{
	int i;
	int count = 0;
	struct mm81x_yaps *yaps = &mors->hif.u.yaps;

	/* We only care about data + mgmt here */
	count += mm81x_skbq_outstanding(&yaps->mgmt_q);

	for (i = 0; i < ARRAY_SIZE(yaps->data_tx_qs); i++)
		count += mm81x_skbq_outstanding(&yaps->data_tx_qs[i]);

	return count;
}

It is fairly easy to opencode something similar, but this looks nice :)
though I can't see many examples of using it like this so I am
a bit cautious.

lachlan

