Return-Path: <linux-wireless+bounces-22190-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CEAA05A2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037571B612F7
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E821D3EF;
	Tue, 29 Apr 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dELq2YZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a8EezwbS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dELq2YZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a8EezwbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD9E26B96E
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915125; cv=none; b=AaNC/oJdSxSysHmW84o+ibDyHhS0ScyJxNY39a1XRjdH99sCphO5MQDzYtk+9ZBZgWji4+wwx/WunmyhSfCSppl1zcuV2KYh3f6P6f9tYAdRASOhh+Ibd2Yd70Np7lehCKiV3DImH+isme3RAPNk06oigzhldHztLeBXJvhj8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915125; c=relaxed/simple;
	bh=rH9UccWYWgoC73rk59ha/zTWI5jwNxSAoFCv2UVXiks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhvOKcmRI1adU0wt3mFxS3KmZzyYPn3GvGLQWsAmKql53gNeYvMMEyKgVpihXiKd43owGGnHj6ETzK727I+tBILMdStCC67oy42VtKijTEoe5UVpPny2fVF7VZlajjpeH3n0elp551nZhLEbJK7jw1HZeZaZrjelKgBy8tCwrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dELq2YZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a8EezwbS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dELq2YZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a8EezwbS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0D402174D;
	Tue, 29 Apr 2025 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745915115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT1i3hdS9mC/hejBjLiByhI9VE+EVpILxulgUDs+hHA=;
	b=dELq2YZaKtBY7eVjiL8nHE2AhixSZMqmIVjkj95xbNc3uZeuvrbIWvAAO1iHDHW71KSoRo
	ocIW5Ti9xvfuR0NPUMJsndZkdUM65cxUhIUPR4Yv2/Vl6JqC9u4ZIASwa9xVXGy5goOPcF
	kipmKieIZ1JJ95ksgnVruPfkcwVgAAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745915115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT1i3hdS9mC/hejBjLiByhI9VE+EVpILxulgUDs+hHA=;
	b=a8EezwbSKoJNBw6rWyp3fwavY0Z3JHCJnQvBVO71F6uGIgeVxvSrOhXRJwhBomXP+Pd4b4
	FiYxAEUM6GfNGBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dELq2YZa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a8EezwbS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745915115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT1i3hdS9mC/hejBjLiByhI9VE+EVpILxulgUDs+hHA=;
	b=dELq2YZaKtBY7eVjiL8nHE2AhixSZMqmIVjkj95xbNc3uZeuvrbIWvAAO1iHDHW71KSoRo
	ocIW5Ti9xvfuR0NPUMJsndZkdUM65cxUhIUPR4Yv2/Vl6JqC9u4ZIASwa9xVXGy5goOPcF
	kipmKieIZ1JJ95ksgnVruPfkcwVgAAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745915115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT1i3hdS9mC/hejBjLiByhI9VE+EVpILxulgUDs+hHA=;
	b=a8EezwbSKoJNBw6rWyp3fwavY0Z3JHCJnQvBVO71F6uGIgeVxvSrOhXRJwhBomXP+Pd4b4
	FiYxAEUM6GfNGBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FC6513931;
	Tue, 29 Apr 2025 08:25:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J7PNJOuMEGgABQAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 29 Apr 2025 08:25:15 +0000
Date: Tue, 29 Apr 2025 11:25:15 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 4/4] wifi: mwifiex: add iw61x support
Message-ID: <20250429082515.45yiafmd7uhyw66p@localhost.localdomain>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250326-mwifiex-iw61x-v1-4-ff875ed35efc@pengutronix.de>
 <Z-Pxx983jcb0GTtg@gaggiata.pivistrello.it>
 <Z-QHG0fyM8wRy2FH@pengutronix.de>
 <Z-UbXduYmx2i0kxz@gaggiata.pivistrello.it>
 <Z-a75VNI9liliHz1@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-a75VNI9liliHz1@pengutronix.de>
X-Rspamd-Queue-Id: C0D402174D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,nxp.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi,

Thank you for your work on this!

On 03-28 16:10, Sascha Hauer wrote:
> On Thu, Mar 27, 2025 at 10:33:17AM +0100, Francesco Dolcini wrote:
> > On Wed, Mar 26, 2025 at 02:54:35PM +0100, Sascha Hauer wrote:
> > > On Wed, Mar 26, 2025 at 01:23:35PM +0100, Francesco Dolcini wrote:
> > > > On Wed, Mar 26, 2025 at 01:18:34PM +0100, Sascha Hauer wrote:
> > > > > This adds iw61x aka SD9177 support to the mwifiex driver. It is named
> > > > > SD9177 in the downstream driver, I deliberately chose the NXP name in
> > > > > the driver.
> > > > > 
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > ---
> > > > >  drivers/net/wireless/marvell/mwifiex/sdio.c | 79 +++++++++++++++++++++++++++++
> > > > >  drivers/net/wireless/marvell/mwifiex/sdio.h |  3 ++
> > > > >  include/linux/mmc/sdio_ids.h                |  3 ++
> > > > >  3 files changed, 85 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > > index cbcb5674b8036..7b4045a40df57 100644
> > > > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> > > > 
> > > > ...
> > > > 
> > > > > @@ -3212,3 +3289,5 @@ MODULE_FIRMWARE(SD8978_SDIOUART_FW_NAME);
> > > > >  MODULE_FIRMWARE(SD8987_DEFAULT_FW_NAME);
> > > > >  MODULE_FIRMWARE(SD8997_DEFAULT_FW_NAME);
> > > > >  MODULE_FIRMWARE(SD8997_SDIOUART_FW_NAME);
> > > > > +MODULE_FIRMWARE(IW612_DEFAULT_FW_NAME);
> > > > > +MODULE_FIRMWARE(IW612_SDIOUART_FW_NAME);
> > > > > diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > > index 65d142286c46e..97759456314b0 100644
> > > > > --- a/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > > +++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
> > > > > @@ -29,6 +29,9 @@
> > > > >  #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
> > > > >  #define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
> > > > >  #define SD8997_SDIOUART_FW_NAME "mrvl/sdiouart8997_combo_v4.bin"
> > > > > +#define IW612_DEFAULT_FW_NAME "nxp/sdsd_nw61x.bin"
> > > > > +#define IW612_SDIOUART_FW_NAME "nxp/sd_w61x.bin"
> > > > 
> > > > Is there a way to have BT over SDIO with iw61x? I was sure only sd-uart was
> > > > possible.
> > > 
> > > The communication to the Bluetooth module indeed is UART only.
> > > 
> > > I think nxp/sdsd_nw61x.bin contains firmwares for both the WiFi and
> > > Bluetooth chip. When using this you can use the Bluetooth UART directly
> > > without uploading a separate Bluetooth firmware.
> > > 
> > > nxp/sd_w61x.bin only contains the WiFi firmware, so you have to
> > > upload a separate Bluetooth firmware over the UART interface.
> > 
> > If that the case what you did here is not correct.
> > 
> > The 2 firmware files here are used file depending on the BT host interface used
> > on the Wi-Fi/BT chip, and this is read from some strapping register. See commit
> > 255ca28a659d ("mwifiex: Select firmware based on strapping").
> > 
> > BTW, this name sdsd_nw61x.bin is confusing, I would have expected this to be
> > something like sduart_nw61x.bin.
> 
> You are right, there seem to be some things mixed up. I'll have a look
> into it for the next round.
> 

Looking at downstream driver looks like based on chip revision firmware
files will be different. My best finding on the firmware files naming about
this chip was this thread [1] on the NXP forums.

Regards,
Ivan

[1] https://community.nxp.com/t5/Other-NXP-Products/NXP-IW612-Kernel-Integration-amp-Firmware-Flashing-Issues/m-p/2056699#M27741


