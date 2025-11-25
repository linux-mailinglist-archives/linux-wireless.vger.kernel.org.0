Return-Path: <linux-wireless+bounces-29317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259CC83980
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2F6F341B78
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153762C15A9;
	Tue, 25 Nov 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AW6hadg9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AyXjOS45";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AW6hadg9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AyXjOS45"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FD286D70
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053900; cv=none; b=j9LCpwhxDBjrdHhYpKVlYJCYt6+y0UN2AXC98AmxHOcI+hzPw4Dy+EXGU9ZKG5Cln8ajw+3JONvDP8Xyddb+Jy+nYG4jGRZMl+C+emzdO4e9r6Ts6MBuHWi8xYKdRDWEyMOjo6C9+H7KVfTiOFao9amPo4lPJYSX9j12MMg3Zk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053900; c=relaxed/simple;
	bh=8VmVTw0qQ9H1O8177KjuvtHhp8+KQ/4jO6ru0JZOOpU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSXJb8AFCqnXie4dhFvaPmxxfAiqVaLmcRZPfVe0Uu1VjLiQrAxHDFyfthnct66obQ8YyLMmZCn4h5hjeO4gjiFR5Rj5i9lHrLo0sZ0sOrNZphivDd1DBpQ17V7v2guQsS2F8gU092py66ao+0OH/rc2DOelRxapn+68fwE32J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AW6hadg9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AyXjOS45; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AW6hadg9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AyXjOS45; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2857C221DA;
	Tue, 25 Nov 2025 06:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764053896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixWK9hLc1qShdGaGWje+3qnkMw6659Wc7/KXxjf4TkU=;
	b=AW6hadg9ExP5p+LiX0va8yttJTS2Tbeal8KVCro2GWevjyLLBxDzh2k9GoyCMc3+5FDNuP
	M4Kc/L50dYmLG4vncuvRe70cJugi93brjqRowH+tBXsRXl58FcBMO4oj8UbA4IVWwSNfJZ
	wsrCRskYduOkviDOYdxHHFDhPoIlJxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764053896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixWK9hLc1qShdGaGWje+3qnkMw6659Wc7/KXxjf4TkU=;
	b=AyXjOS45ED4DMzovJU8P+iAQoT1qApCyHnkF7yQ62bE+BKlCji8jn7XGBSRlTSayOp+CgO
	1njOg4IvvrIARkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764053896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixWK9hLc1qShdGaGWje+3qnkMw6659Wc7/KXxjf4TkU=;
	b=AW6hadg9ExP5p+LiX0va8yttJTS2Tbeal8KVCro2GWevjyLLBxDzh2k9GoyCMc3+5FDNuP
	M4Kc/L50dYmLG4vncuvRe70cJugi93brjqRowH+tBXsRXl58FcBMO4oj8UbA4IVWwSNfJZ
	wsrCRskYduOkviDOYdxHHFDhPoIlJxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764053896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixWK9hLc1qShdGaGWje+3qnkMw6659Wc7/KXxjf4TkU=;
	b=AyXjOS45ED4DMzovJU8P+iAQoT1qApCyHnkF7yQ62bE+BKlCji8jn7XGBSRlTSayOp+CgO
	1njOg4IvvrIARkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02BCA3EA63;
	Tue, 25 Nov 2025 06:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XQkxO4dTJWnRLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Nov 2025 06:58:15 +0000
Date: Tue, 25 Nov 2025 07:58:15 +0100
Message-ID: <87cy56ppiw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>
Cc: "Takashi Iwai" <tiwai@suse.de>,
	"Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org
Subject: Re: [PATCH] wifi: ath11k: Add quirk entry for Thinkpad T14s Gen3 AMD
In-Reply-To: <3b97881b-b21a-48ca-91f0-cbfac966ea76@app.fastmail.com>
References: <20251124134713.5819-1-tiwai@suse.de>
	<cb594fb5-faa3-4c6a-8ece-d2e176e196df@app.fastmail.com>
	<878qfvqwdo.wl-tiwai@suse.de>
	<3b97881b-b21a-48ca-91f0-cbfac966ea76@app.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Mon, 24 Nov 2025 16:52:07 +0100,
Mark Pearson wrote:
> 
> On Mon, Nov 24, 2025, at 10:32 AM, Takashi Iwai wrote:
> > On Mon, 24 Nov 2025 16:13:05 +0100,
> > Mark Pearson wrote:
> >> 
> >> Thanks Takashi-san,
> >> 
> >> On Mon, Nov 24, 2025, at 8:47 AM, Takashi Iwai wrote:
> >> > The recent kernels showed a regression wrt suspend/resume on Lenovo
> >> > Thinkpad T14s Gen 3 AMD model; it fails to reconnect on resume after a
> >> > long time sleep.  The only workaround was to unload/reload the driver
> >> > (or reboot).
> >> >
> >> > It seems that this model also requires the similar quirk with
> >> > ATH11K_PM_WOW which has been done for other Thinkpad models.
> >> >
> >> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1254181
> >> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >> > ---
> >> >
> >> > I'm not sure whether this model has another DMI entry, so put Mark to
> >> > Cc.
> >> >
> >> > Also, I wonder which Thinkpad models are rather the ones that should
> >> > *not* take the quirk.  Since mine is Gen 3 and I already see Gen 2
> >> > entries, which else remaining...?
> >> >
> >> 
> >> It should only apply to models with the ath11k modem - but it looks like Gen 2 up to Gen 6....which is quite a lot. I don't know if all of those are impacted.
> >> I think we'll have to do more testing and get feedback from the FW team, which will take a bit I'm afraid. I'll look into it.
> >
> > I see, thanks for confirmation!
> >
> >> >
> >> >  drivers/net/wireless/ath/ath11k/core.c | 7 +++++++
> >> >  1 file changed, 7 insertions(+)
> >> >
> >> > diff --git a/drivers/net/wireless/ath/ath11k/core.c 
> >> > b/drivers/net/wireless/ath/ath11k/core.c
> >> > index 812686173ac8..3aa78a39394b 100644
> >> > --- a/drivers/net/wireless/ath/ath11k/core.c
> >> > +++ b/drivers/net/wireless/ath/ath11k/core.c
> >> > @@ -924,6 +924,13 @@ static const struct dmi_system_id 
> >> > ath11k_pm_quirk_table[] = {
> >> >  			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
> >> >  		},
> >> >  	},
> >> > +	{
> >> > +		.driver_data = (void *)ATH11K_PM_WOW,
> >> > +		.matches = { /* T14s G3 AMD */
> >> > +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> > +			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
> >> > +		},
> >> > +	},
> >> >  	{
> >> >  		.driver_data = (void *)ATH11K_PM_WOW,
> >> >  		.matches = { /* T14 G4 AMD #1 */
> >> > -- 
> >> > 2.52.0
> >> 
> >> I think you need to add the "21CQ" Product Name for this platform too (every model has two IDs depending on where in the world it is deployed)
> >> 
> >> Unfortunately my T14s G3 AMD seems to be dead :( I can't test and confirm directly.
> >
> > OK, I can resubmit with 21CQ entry later.
> >
> > Also, maybe it'd be worth for adding a module option to specify /
> > override the quirk, so that one can test without recompiling the
> > kernel?
> >
> Yeah - that could be useful so users can confirm if they need the quirk too (especially if platforms outside of the Linux program are impacted). It gets my vote :)
> 
> Mark

OK, it'd be like below.


Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] wifi: ath11k: Add pm_wow module option

This provides a new module option "pm_wow" for forcibly enabling or
disabling the PM WoW policy.  It helps for debugging the machines that
have a PM problem, so that user can test without recompiling the
kernel -- there are lots of Thinkpad models and some of them may still
need WoW behavior.

As default, the option takes -1, which means to follow the DMI quirk
list and falls back to the default policy.  If the option is given
(either 0 or 1), it precedes and the PM policy is set to that value.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/ath/ath11k/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 4daaeb5e0ab8..f497ea3a3a2e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -39,6 +39,10 @@ bool ath11k_ftm_mode;
 module_param_named(ftm_mode, ath11k_ftm_mode, bool, 0444);
 MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
 
+static int ath11k_pm_wow = -1;
+module_param_named(pm_wow, ath11k_pm_wow, bint, 0444);
+MODULE_PARM_DESC(pm_wow, "Force to enable/disable WoW PM policy");
+
 static const struct ath11k_hw_params ath11k_hw_params[] = {
 	{
 		.hw_rev = ATH11K_HW_IPQ8074,
@@ -2618,11 +2622,16 @@ int ath11k_core_init(struct ath11k_base *ab)
 	const struct dmi_system_id *dmi_id;
 	int ret;
 
-	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
-	if (dmi_id)
-		ab->pm_policy = (kernel_ulong_t)dmi_id->driver_data;
-	else
-		ab->pm_policy = ATH11K_PM_DEFAULT;
+	if (ath11k_pm_wow >= 0) {
+		ath11k_info(ab, "force to set PM WoW: %d\n", ath11k_pm_wow);
+		ab->pm_policy = ath11k_pm_wow;
+	} else {
+		dmi_id = dmi_first_match(ath11k_pm_quirk_table);
+		if (dmi_id)
+			ab->pm_policy = (kernel_ulong_t)dmi_id->driver_data;
+		else
+			ab->pm_policy = ATH11K_PM_DEFAULT;
+	}
 
 	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
 
-- 
2.52.0


