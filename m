Return-Path: <linux-wireless+bounces-12893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F797A2C5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BC3289C0E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E04155741;
	Mon, 16 Sep 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="05DyxjdA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72jIsFBy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="05DyxjdA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="72jIsFBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B4155725
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492448; cv=none; b=Ch22nByctovbHOTtTqJynYnHjFR7gxSauA+j6RvL/uTlhJFnDjl9bTREy6cNNgES5FLI2EU1mRJ/JcIPjmCqWntmYubXEmpChvLEGCvuBlCFnWNOJVRDnyXOXfekNFGdt9mJQdBudndySMschHI2I8JCAorkAbB6ReDFlN0f3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492448; c=relaxed/simple;
	bh=zs8hJv5dfpdpF4eGwD2STNJbuH56G31sid03iXbBnz4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBeK20BVgKqNeD2I0578ZPF2v3yFnD0u/ljgxQ+XDT5jC8eDIGfC7mCJ1YWcV927ZcFs/cDADGV1LoAnJVRyhRpcOVowgIleyT8Y7Xf7Xe6zP7jQBd43cnY1GR0cU4VFxNjckIMuFvmcole2HlDXrCyxhGlClDLWyc9U6ye4Pis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=05DyxjdA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72jIsFBy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=05DyxjdA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=72jIsFBy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31D5B21A93;
	Mon, 16 Sep 2024 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726492445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Irbl9EoTjr+urz93WnqRS2vptqXGtuqNgIQPPWPNPfg=;
	b=05DyxjdAUjHbaUwLetQECpGMe7fNtoHZaUuHXtJVKzsY1yZ1+tlMlkx61arbHHgSX5T37R
	E/XmjdBpFTda5pi3F6Q/gC/Q6lqR8Z+R+okK9PYs8pfhpjqz4xMC0UiAS5O5EgG5niuP5v
	KakscmbIBPcAN0pP3MfEDeh6e9GN/J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726492445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Irbl9EoTjr+urz93WnqRS2vptqXGtuqNgIQPPWPNPfg=;
	b=72jIsFByJbiFSGLtWKTueuQ/BM8xm4PGtc1+ybn+n5VPR/umA9YMKqfvJRpzltW7/rf0qo
	VmQy5yfxH4yO1fDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=05DyxjdA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=72jIsFBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726492445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Irbl9EoTjr+urz93WnqRS2vptqXGtuqNgIQPPWPNPfg=;
	b=05DyxjdAUjHbaUwLetQECpGMe7fNtoHZaUuHXtJVKzsY1yZ1+tlMlkx61arbHHgSX5T37R
	E/XmjdBpFTda5pi3F6Q/gC/Q6lqR8Z+R+okK9PYs8pfhpjqz4xMC0UiAS5O5EgG5niuP5v
	KakscmbIBPcAN0pP3MfEDeh6e9GN/J8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726492445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Irbl9EoTjr+urz93WnqRS2vptqXGtuqNgIQPPWPNPfg=;
	b=72jIsFByJbiFSGLtWKTueuQ/BM8xm4PGtc1+ybn+n5VPR/umA9YMKqfvJRpzltW7/rf0qo
	VmQy5yfxH4yO1fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06A071397F;
	Mon, 16 Sep 2024 13:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aI9qOxwv6GZFGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Sep 2024 13:14:04 +0000
Date: Mon, 16 Sep 2024 15:14:55 +0200
Message-ID: <875xqvivu8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: ath12k firmware regression with update 82318c966fd1
In-Reply-To: <875xqveok5.fsf@kernel.org>
References: <87bk0nc1yb.wl-tiwai@suse.de>
	<875xqveok5.fsf@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 31D5B21A93
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,suse.com:url,archlinux.org:url];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Mon, 16 Sep 2024 15:05:46 +0200,
Kalle Valo wrote:
> 
> Takashi Iwai <tiwai@suse.de> writes:
> 
> > it seems that the recent update of ath12k WCN7850 board-2.bin update
> > broke WiFi on Lenovo Thinkpad 14 Gen 5 AMD.  Reverting to the older
> > firmware seems fixing the issue.
> 
> Just to clarify, reverting to an older board-2.bin seems to fix the
> issue. (Board files are basically calibration data)
> 
> > The report for openSUSE Tumbleweed is found at
> >   https://bugzilla.suse.com/show_bug.cgi?id=1230596
> > and for Arch
> >   https://bbs.archlinux.org/viewtopic.php?id=299286
> 
> For easier tracking can someone file a bug to bugzilla.kernel.org? Also
> please include more information:
> 
> https://wireless.wiki.kernel.org/en/users/drivers/ath12k/bugreport

Opened now:
  https://bugzilla.kernel.org/show_bug.cgi?id=219282

> > Let me know if it's already handled in Qualcomm and the fix is
> > expected shortly.  Otherwise I'll try to revert the change locally for
> > TW as a temporary solution.
> 
> This is the first time I'm hearing about this and to my knowledge there
> is not fix pending.

OK, thanks for the information!


Takashi

