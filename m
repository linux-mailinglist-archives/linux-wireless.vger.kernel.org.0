Return-Path: <linux-wireless+bounces-18827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B6AA31FE9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A28163450
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54ED2040A4;
	Wed, 12 Feb 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b2lg24Si";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Vr7XAC/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b2lg24Si";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4Vr7XAC/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2F1FECB3;
	Wed, 12 Feb 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345030; cv=none; b=KNC9mrowzY55sTrsQOwDGrQQuz4KL2RWzUzkzj/avsyCSDSP7GuOReq7VQANIjhUIL7JpPFiymZsHzKoIvXoJzHmRDgoZxBz0+p8wKAEyax9QfWiUao1TrIkZPjkSpgZFOrXo9mwf0r3uM01jug56RFoUJs1/v2Ek66m6CKoLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345030; c=relaxed/simple;
	bh=bl4xDoxT8z1IrzzVtup/QS7W9VFUalxmHdsH49LoM+w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCpKpGegHo9wiWlW1J3+Q+Amigf2fbsnhAYDGAqekk5EcwMPEV/LZlZTmD+WiUDBAyV2VDJe1O3uU8oJyTix14h3x2TBX31evIOXJzbzDXCvoqGpsqKmd3VRYAbQ5aF+SQaYMHwh7RhFsvGUTR1eYR+N/xOagXjLGPOYkKl2KuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b2lg24Si; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Vr7XAC/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b2lg24Si; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4Vr7XAC/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D63341FF19;
	Wed, 12 Feb 2025 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739345026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvJSPQHcK5MFEXKW/OC96t6LwbJhmbrZ9DXW3TeMrsc=;
	b=b2lg24Siii6BpuMpn5+WpHzhotOKiQN+8FqqOLUG9fYM0rv7Q0AiPAjQXjGkV6k7D1DEYt
	0F1O31yZPc+haugUEKyukohnd8oy+D591u28y5MmhAuzjG6or63EedTYuG0N93n56RNgGW
	PAyle7bcWpVVe2NpqHC5x6oNNoo4Xqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739345026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvJSPQHcK5MFEXKW/OC96t6LwbJhmbrZ9DXW3TeMrsc=;
	b=4Vr7XAC/or0pMyv/HfeXxWxY6FXjoF85Z+/ALgZtL5mYp5m+awaWIHbmuS5MM9NJfaidA3
	nd6p1u1pACF9P/BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739345026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvJSPQHcK5MFEXKW/OC96t6LwbJhmbrZ9DXW3TeMrsc=;
	b=b2lg24Siii6BpuMpn5+WpHzhotOKiQN+8FqqOLUG9fYM0rv7Q0AiPAjQXjGkV6k7D1DEYt
	0F1O31yZPc+haugUEKyukohnd8oy+D591u28y5MmhAuzjG6or63EedTYuG0N93n56RNgGW
	PAyle7bcWpVVe2NpqHC5x6oNNoo4Xqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739345026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvJSPQHcK5MFEXKW/OC96t6LwbJhmbrZ9DXW3TeMrsc=;
	b=4Vr7XAC/or0pMyv/HfeXxWxY6FXjoF85Z+/ALgZtL5mYp5m+awaWIHbmuS5MM9NJfaidA3
	nd6p1u1pACF9P/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6A813AEF;
	Wed, 12 Feb 2025 07:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YlNXKIJMrGcAGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 12 Feb 2025 07:23:46 +0000
Date: Wed, 12 Feb 2025 08:23:46 +0100
Message-ID: <87h64zmxrx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: jack Livingood <jacklivingood@comcast.net>
Cc: sfr@canb.auug.org.au,
	tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/4] sounds: firewire: isight: changed strcpy to strscpy
In-Reply-To: <20250212012346.83516-1-jacklivingood@comcast.net>
References: <20250212012346.83516-1-jacklivingood@comcast.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[comcast.net];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[comcast.net];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 12 Feb 2025 02:23:46 +0100,
jack Livingood wrote:
> 
> From: Jack Livingood <jacklivingood@comcast.net>
> 
> fixed a spelling issue in the commit made previous

I already discarded your previous patch, so please give a full
description.


Takashi

> 
> Signed-off-by: Jack Livingood <jacklivingood@comcast.net>
> ---
>  sound/firewire/isight.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/firewire/isight.c b/sound/firewire/isight.c
> index 806f82c9ceee..e9617fc0a532 100644
> --- a/sound/firewire/isight.c
> +++ b/sound/firewire/isight.c
> @@ -637,13 +637,13 @@ static int isight_probe(struct fw_unit *unit,
>  
>  	card->private_free = isight_card_free;
>  
> -	strcpy(card->driver, "iSight");
> -	strcpy(card->shortname, "Apple iSight");
> +	strscpy(card->driver, "iSight");
> +	strscpy(card->shortname, "Apple iSight");
>  	snprintf(card->longname, sizeof(card->longname),
>  		 "Apple iSight (GUID %08x%08x) at %s, S%d",
>  		 fw_dev->config_rom[3], fw_dev->config_rom[4],
>  		 dev_name(&unit->device), 100 << fw_dev->max_speed);
> -	strcpy(card->mixername, "iSight");
> +	strscpy(card->mixername, "iSight");
>  
>  	err = isight_create_pcm(isight);
>  	if (err < 0)
> -- 
> 2.48.1
> 

