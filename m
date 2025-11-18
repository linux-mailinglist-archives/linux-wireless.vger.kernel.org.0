Return-Path: <linux-wireless+bounces-29101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE1C694B8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 13:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D80FF2B826
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301230FC13;
	Tue, 18 Nov 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MUdUDDK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e4y1rm/Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MUdUDDK+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e4y1rm/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F61351FA9
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467846; cv=none; b=eknW8qNY1iIOveo3zuYUlRkf9UbgeU1r6WERxGW2iahIuUTAA2eOU4urMr+CaFJaSC7IdJtED6pOMB8CPXXSkwakfif4L69inKmYgMhEnSuJ7Hhg9s8/MSUcMiMeTPj3Z19ZLouimpwv4TawY0lmHgOEk9dee8pEUnGuBteMhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467846; c=relaxed/simple;
	bh=Lir2jT7nj5btLZjyRsA6eOwMvDvtiBzh3QXivcKpvzc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khtO6B7Z7wBJtLifBzx054g0O8oU4i4MjOQPfupChAGwnUGXXlyCZh9kepxv0fkMCF7fLQlpC+g2/fKPvC/+Bjf0xYcyE/8rrYjMbU2EPnrqdIPciQjqkoCWQdgSh2GyIRtVUixRernJmjsE0jaMrC5cVMY4N3JPE7BG8GKTQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MUdUDDK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e4y1rm/Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MUdUDDK+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e4y1rm/Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 793F11FE30;
	Tue, 18 Nov 2025 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSH9f2rexmRjEUdRuocmH9YhxKtdWRYB83hH7gDfDWY=;
	b=MUdUDDK+2Z///ikeCcDKnFmSVgkbKo3RRdFyQkGuAVspuc3yrEyD2kWUlVI3Zc00AnLbss
	eDSnE8bGUcuchFsLangFtvdCQhNzTeevx9it8eQcdO0VRMlIWV0Dngu4T2NWpOSr7mrGRa
	IaiVPPoHPr5be5hk+bdvhPoyY80KJ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSH9f2rexmRjEUdRuocmH9YhxKtdWRYB83hH7gDfDWY=;
	b=e4y1rm/QmwUWDnJ8xJpJsghuifba1w5zXpAnI+LpUm4frnc+ovTDziRaF0nLueR+EFzJVi
	PDHzYM5uqR9ZqeAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763467842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSH9f2rexmRjEUdRuocmH9YhxKtdWRYB83hH7gDfDWY=;
	b=MUdUDDK+2Z///ikeCcDKnFmSVgkbKo3RRdFyQkGuAVspuc3yrEyD2kWUlVI3Zc00AnLbss
	eDSnE8bGUcuchFsLangFtvdCQhNzTeevx9it8eQcdO0VRMlIWV0Dngu4T2NWpOSr7mrGRa
	IaiVPPoHPr5be5hk+bdvhPoyY80KJ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763467842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSH9f2rexmRjEUdRuocmH9YhxKtdWRYB83hH7gDfDWY=;
	b=e4y1rm/QmwUWDnJ8xJpJsghuifba1w5zXpAnI+LpUm4frnc+ovTDziRaF0nLueR+EFzJVi
	PDHzYM5uqR9ZqeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65AA03EA61;
	Tue, 18 Nov 2025 12:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdpBGEJiHGlweAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Nov 2025 12:10:42 +0000
Date: Tue, 18 Nov 2025 13:10:42 +0100
Message-ID: <87jyznee2l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH] wifi: iwlwifi: Add missing firmware info for bz-b0-* models
In-Reply-To: <DM3PPF63A6024A9B48F90D1FB104CBEFC22A3F4A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
References: <20251015141307.25305-1-tiwai@suse.de>
	<DM3PPF63A6024A9B48F90D1FB104CBEFC22A3F4A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[intel.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.com:url];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sun, 19 Oct 2025 13:54:14 +0200,
Korenblit, Miriam Rachel wrote:
> 
> 
> > Cc: linux-wireless@vger.kernel.org; Berg, Johannes <johannes.berg@intel.com>
> > Subject: [PATCH] wifi: iwlwifi: Add missing firmware info for bz-b0-* models
> 
> Please specify the destination tree for this patch, we have iwlwifi-next and iwlwifi-fixes.
> So yours should probably be [PATCH iwlwifi-next] ....
> > 
> > The module firmware info is missing for iwlwifi-bz-b0-* models, which results in
> > the non-working WiFi on some installers or images.
> > 
> > Add the entries for iwlwifi-bz-b0-fm-c0, iwlwifi-bz-b0-gf-a0 and iwlwifi-bz-b0-hr-
> > b0.
> > 
> > Link: https://bugzilla.suse.com/show_bug.cgi?id=1252084
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
> > b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
> > index 3e6206e739f6..44a00acce81f 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
> > @@ -22,6 +22,9 @@
> >  #define IWL_BZ_A_FM_B_FW_PRE		"iwlwifi-bz-a0-fm-b0"
> >  #define IWL_BZ_A_FM_C_FW_PRE		"iwlwifi-bz-a0-fm-c0"
> >  #define IWL_BZ_A_FM4_B_FW_PRE		"iwlwifi-bz-a0-fm4-b0"
> > +#define IWL_BZ_B_FM_C_FW_PRE		"iwlwifi-bz-b0-fm-c0"
> > +#define IWL_BZ_B_GF_A_FW_PRE		"iwlwifi-bz-b0-gf-a0"
> > +#define IWL_BZ_B_HR_B_FW_PRE		"iwlwifi-bz-b0-hr-b0"
> >  #define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0"
> >  #define IWL_GL_C_FM_C_FW_PRE		"iwlwifi-gl-c0-fm-c0"
> > 
> > @@ -104,5 +107,8 @@ const struct iwl_mac_cfg iwl_gl_mac_cfg = {
> > IWL_CORE_FW(IWL_BZ_A_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > IWL_CORE_FW(IWL_BZ_A_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > IWL_CORE_FW(IWL_BZ_A_FM4_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > +IWL_CORE_FW(IWL_BZ_B_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > +IWL_CORE_FW(IWL_BZ_B_GF_A_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > +IWL_CORE_FW(IWL_BZ_B_HR_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> >  IWL_CORE_FW(IWL_GL_B_FM_B_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> > IWL_CORE_FW(IWL_GL_C_FM_C_FW_PRE, IWL_BZ_UCODE_CORE_MAX);
> 
> Those FW files should really be added to the relevant rf-*.h files
> (yes, I know there are already others here but those should move as well)
> 
> So for example, iwlwifi-bz-b0-fm-c0 should go to rf-fm.h etc.

Sorry for the late reaction, as I was too much side-tracked.

I saw you already moved the stuff into rf-fm.c on linux-next, so I'm
going to resubmit v2 after the rebase.


thanks,

Takashi

