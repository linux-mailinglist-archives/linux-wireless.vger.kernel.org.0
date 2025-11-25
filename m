Return-Path: <linux-wireless+bounces-29325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE3C83BFE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CA0A4E0536
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2552D0C76;
	Tue, 25 Nov 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HgFbRFN2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0TVAActQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gM6+bMyT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rSVRz2ai"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C53286881
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056416; cv=none; b=TA7MgToK3np1bB0D+aqTkNy/AImWCxpRUhOwx2K4C1MsmVmc/NfPMBcQFbrnnWx5q0iCT37EVft45ghivlILjrQ+7djc8B9mhSOzjGdYdcH4XONwta5Ji2ySrTxKwKJFqyMeKBvGvUYBDf9hymELAIGZHpD8VLPV8slFUwvw5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056416; c=relaxed/simple;
	bh=QQw/u3sKhifxmJ6twf3/zglDrOAo1lu8vRyVcBAAn2M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgg/cqLlH9MCpYYqMWaluMd8iDnZISKbs0bGEoh2a7ZEhdvgzqQfo4JBUCY+wBsBaRmZdzxa3aYPdiyfhXn5zo6lSysg0JpwNIepaiL/Fxy6PEO53xte5IEwrEBy/mKq/ZyCurYHXx22GpPtXD227EVSskaPeUuz8Eki2fYDBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HgFbRFN2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0TVAActQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gM6+bMyT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rSVRz2ai; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D412B5BCE5;
	Tue, 25 Nov 2025 07:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764056413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRvbrDXMlUapeNa4jzEy/DlJZgXccZdRA4u21/uqA+g=;
	b=HgFbRFN225sNsD3SaPgvKBv2G/EEaAwvAE3HVY3pAirujTqMABU4eEL8xGR8Yti1qb+9ul
	sbC5jVLqGjKD6ZONbRn5z3I7WYyTY0dv9vg2qlQRwSTNrmdOfKPErFb0M/v+K/yilFgsiE
	0h17CISijuHJZptemq9OUWGQmhQHs8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764056413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRvbrDXMlUapeNa4jzEy/DlJZgXccZdRA4u21/uqA+g=;
	b=0TVAActQP918GvH+XZJQMzX8Hfbxg8f+NCOd7T1/GIMSELTXuWHxyYE2ZLa9pjTPpRWoAd
	U7rtqwoCyUdWBVAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gM6+bMyT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rSVRz2ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764056412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRvbrDXMlUapeNa4jzEy/DlJZgXccZdRA4u21/uqA+g=;
	b=gM6+bMyTQ+styOCbndNUPSiezq5f2WAkKCc8+M/+6aeVvxpzVwVgQDm1yfAuJ5/hz4EJsR
	UsPW7m5+lurbzRs5f1PaMg7r9mk+FJEP2WF+IqwrNFxS0l4KKUEa3csnKIm5oRUDT7rdyp
	pIXN/2kOHAAPULNGU1a7ttOzj9t/jCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764056412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRvbrDXMlUapeNa4jzEy/DlJZgXccZdRA4u21/uqA+g=;
	b=rSVRz2airFAIoZeCsE9pXwJJZ0xt59LC1HyarXMe6eKFYTmL3T9aPMyIFOAeB0nJxYmIez
	TtblqQEgFEPLrMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A77583EA63;
	Tue, 25 Nov 2025 07:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UZKlJ1xdJWl9VQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Nov 2025 07:40:12 +0000
Date: Tue, 25 Nov 2025 08:40:12 +0100
Message-ID: <875xaypnkz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
In-Reply-To: <277cfe97-3024-4e65-8766-7b96646c5120@oss.qualcomm.com>
References: <20251124134713.5819-1-tiwai@suse.de>
	<2faa8f4e-cb30-4e91-87d2-853c90458b01@oss.qualcomm.com>
	<87ecpmppkt.wl-tiwai@suse.de>
	<277cfe97-3024-4e65-8766-7b96646c5120@oss.qualcomm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: D412B5BCE5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url,suse.de:email,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

On Tue, 25 Nov 2025 08:25:12 +0100,
Baochen Qiang wrote:
> 
> 
> 
> On 11/25/2025 2:57 PM, Takashi Iwai wrote:
> > On Tue, 25 Nov 2025 03:28:22 +0100,
> > Baochen Qiang wrote:
> >>
> >>
> >>
> >> On 11/24/2025 9:47 PM, Takashi Iwai wrote:
> >>> The recent kernels showed a regression wrt suspend/resume on Lenovo
> >>> Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
> >>> long time sleep.  The only workaround was to unload/reload the driver
> >>
> >> how long? and with a short suspend you don't see the issue?
> > 
> > I can't say exactly, but usually after some hours.  I see it happening
> > when the machine is resumed in the morning after an overnight sleep.
> > Short suspends can resume mostly, as far as I tested.
> > 
> >>> (or reboot).
> >>>
> >>> It seems that this model also requires the similar quirk with
> >>> ATH11K_PM_WOW which has been done for other Thinkpad models.
> >>
> >> the quirk is to workaround the unexpected wakeup issue, which seems not the same with
> >> yours. Hence not sure if this is the right fix.
> > 
> > Yes, I wonder that, too.  The whole suspend/resume procedure look
> > fairly different with PM WoW quirk, so some of them might matter.
> > 
> >>> Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
> >>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >>> ---
> >>>
> >>> I'm not sure whether this model has another DMI entry, so put Mark to
> >>> Cc.
> >>>
> >>> Also, I wonder which Thinkpad models are rather the ones that should
> >>> *not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
> >>> entries, which else remaining...?
> >>>
> >>>
> >>>  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
> >>>  1 file changed, 7 insertions(+)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> >>> index 812686173ac8..3aa78a39394b 100644
> >>> --- a/drivers/net/wireless/ath/ath11k/core.c
> >>> +++ b/drivers/net/wireless/ath/ath11k/core.c
> >>> @@ -924,6 +924,13 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
> >>>  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
> >>>  		},
> >>>  	},
> >>> +	{
> >>> +		.driver_data = (void *)ATH11K_PM_WOW,
> >>> +		.matches = { /* T14s G3 AMD */
> >>> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>> +			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
> >>> +		},
> >>> +	},
> >>
> >> so with the change, the issue is not seen after a __long__ suspend?
> > 
> > Right, the connection gets resumed properly.
> > 
> >>>  	{
> >>>  		.driver_data = (void *)ATH11K_PM_WOW,
> >>>  		.matches = { /* T14 G4 AMD #1 */
> >>
> >> Hmm, I am feeling that we need to dig more to root cause this issue. Can you please help
> >> to collect verbose wpa_supplicant/iwd log and kernel log?
> >>
> >> wpa_supplicant:
> >> 	cd /lib/systemd/system
> >> 	diff --git a/wpa_supplicant.service b/wpa_supplicant.service
> >> 	index d5c7ef8..69693d0 100644
> >> 	--- a/wpa_supplicant.service
> >> 	+++ b/wpa_supplicant.service
> >> 	@@ -5,7 +5,8 @@ Before=network.target
> >> 	 [Service]
> >> 	 Type=dbus
> >> 	 BusName=fi.epitest.hostap.WPASupplicant
> >> 	-ExecStart=/sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
> >> 	+ExecStart=/sbin/wpa_supplicant -u -s -t -f/var/log/wpa_supplicant.log -dd -O
> >> /run/wpa_supplicant
> >>
> >>
> >> IWD:
> >> simply add '-d' option when starting it. You may directly add it to the systemd service
> >> entry if you like. See
> >>
> >> https://archive.kernel.org/oldwiki/iwd.wiki.kernel.org/debugging.html
> > 
> > OK, I'll try to get the log (in tomorrow morning :)
> > 
> > Meanwhile, the PM WoW quirk looks fine for this Thinkpad model, I see
> > no other regression with the quirk.  As a stop gap, would it be
> > acceptable?  If yes, I'll resubmit with the entry of another Gen 3
> > model Mark suggested.
> 
> I would suggest you waiting before we root cause, or at least before logs are collected
> and investigated. Then let's see what we do next.

OK, fair enough.


Takashi

