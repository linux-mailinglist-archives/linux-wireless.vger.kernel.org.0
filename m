Return-Path: <linux-wireless+bounces-33330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHh3NS4auWkBqgEAu9opvQ
	(envelope-from <linux-wireless+bounces-33330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:09:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA912A6419
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 10:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F96302E410
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2026 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3235836F;
	Tue, 17 Mar 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTsRRDYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sEhq3izu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QTsRRDYM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sEhq3izu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F17034DB66
	for <linux-wireless@vger.kernel.org>; Tue, 17 Mar 2026 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738444; cv=none; b=PZtCJyHWKMyBlBDsMD9+GvW1puGGMxDc1xBOI3/DAv5lDYoNzEf8xsn/EpJQ20uatmtH7HdaJ10eJUkBXICh3lWie43fGGLqVZpr9xhOaUYKjRlc0edYh3g0/zJB6lf9zBz18Ac5Ryu7hUFjqbC8TqQzkzLEJIyZymMjG1k937o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738444; c=relaxed/simple;
	bh=QuYrBAsBv7vcdizE/S4T63R7Qg05vTZjRNFb3DPTF7o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWDNxFkNzQScGwaN7lNO65AvknhFtglbWSm5o6J9CYuA+9VJ1xllgByN1cZtB2pZdDD8edTxLae28+vijnM+wmdUjDyjThclMSlVFk+wqcwlSMFmKsUdXafzfodiiZWLA7JKow+ZhwNxXJrCrFAJt9gKR7Js9pqG4bb8VBRYkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTsRRDYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sEhq3izu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QTsRRDYM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sEhq3izu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E5F54D301;
	Tue, 17 Mar 2026 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773738441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6iQDme+4pl0VVtlEzwn4J0Z5GPchMZ4qJMefnm2uWA=;
	b=QTsRRDYMLYhsJNdBEPITMfAVz818hsTy9ECgT4e9MaQNJOwNAS31S+qtDfZlm8BtE65kWT
	hLxRqWxmcm5rkQ2iC/QcL+0yE+0vVZIhmnk18tASSgWKXfZhTFuRPKcL1NXaDtoJOYAz7X
	oGtvuaxJWTQfLq8QfD2Wu0rJe8RNaf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773738441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6iQDme+4pl0VVtlEzwn4J0Z5GPchMZ4qJMefnm2uWA=;
	b=sEhq3izugF5n7YcaEZFEsBVf+7dmR7cXPGILdBbnajzu50dYzKaJOz+alDwJkKTXal6V7N
	wShGAzLpvEbJztAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QTsRRDYM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sEhq3izu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773738441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6iQDme+4pl0VVtlEzwn4J0Z5GPchMZ4qJMefnm2uWA=;
	b=QTsRRDYMLYhsJNdBEPITMfAVz818hsTy9ECgT4e9MaQNJOwNAS31S+qtDfZlm8BtE65kWT
	hLxRqWxmcm5rkQ2iC/QcL+0yE+0vVZIhmnk18tASSgWKXfZhTFuRPKcL1NXaDtoJOYAz7X
	oGtvuaxJWTQfLq8QfD2Wu0rJe8RNaf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773738441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6iQDme+4pl0VVtlEzwn4J0Z5GPchMZ4qJMefnm2uWA=;
	b=sEhq3izugF5n7YcaEZFEsBVf+7dmR7cXPGILdBbnajzu50dYzKaJOz+alDwJkKTXal6V7N
	wShGAzLpvEbJztAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C778B4273B;
	Tue, 17 Mar 2026 09:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FtMGLsgZuWkjEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 17 Mar 2026 09:07:20 +0000
Date: Tue, 17 Mar 2026 10:07:20 +0100
Message-ID: <875x6ug6yf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org,
	andersson@kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Elder <elder@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 4/4] ALSA: usb-audio: qcom: Use the unified QMI service ID instead of defining it locally
In-Reply-To: <20260316171419.2619620-5-daniel.lezcano@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
	<20260316171419.2619620-5-daniel.lezcano@oss.qualcomm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -2.01
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-33330-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: 3BA912A6419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 18:14:14 +0100,
Daniel Lezcano wrote:
> 
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

For the sound bits,

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

