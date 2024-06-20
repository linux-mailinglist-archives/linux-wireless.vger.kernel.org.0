Return-Path: <linux-wireless+bounces-9303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12583910348
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBDFF1F229B1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8511ABCB1;
	Thu, 20 Jun 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="U6B0yRLm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fy2eZmTk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h+VSl7kp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z32At5aS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E881AB536;
	Thu, 20 Jun 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883879; cv=none; b=EpD2C2ylG7BpLn7U64nrVfEGVGydJ2nFQCquKXMHVDj4cOEraMKfEP6EmIOUO5TrRZgMFQ2HU8tvvS4oTLEvLS/Apsj8qoEWbvOkq/KLx1mCV9onvhE1BcAWYSnCvUTaLveLySCHtkRJnC1y7x+R+Vr6kZY079SYqGSWY+L29wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883879; c=relaxed/simple;
	bh=TYNAP8w8oW0EvEDUT7BNV7orWIDnIGlzwhRnmiM/TQI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhfz6imD/ELjbYXiPqacOhThet1GDDybN5vy9NBzGQWTfAMQk3t69lZbq7LiAKhxBrvnSoYiXQ958XrwxaNwxFzbzR35bavoGTcJ6wf4YSuFal2eB5VHjRyTK1nwxjsEfL8gJl97c/zWeGTBKskWRbPbRV9qOUv4HVVUhetLn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=U6B0yRLm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fy2eZmTk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h+VSl7kp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z32At5aS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1F5821A4F;
	Thu, 20 Jun 2024 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718883876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVxr5+YUGGwjZxTP0c/O6rsm9IQX/jRGZRqdKqMPcXo=;
	b=U6B0yRLmQF2fyDvo14B5gQKWVG7W/DcqpAMMfxYa5TrUhhzXOa30quZVJkkThr4O9Beh6r
	KDFZJ/xv5keE3fFi3Q4LPrx2uGm7gS+dusUrcIsiXj31nQUK11civNzVsOVFnyz8w3MC6R
	lQ7ZknkmUgI5WNvVSiZyNOS4MsHb6nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718883876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVxr5+YUGGwjZxTP0c/O6rsm9IQX/jRGZRqdKqMPcXo=;
	b=Fy2eZmTkdn2sTwYEL3ZQ1OMKj7trzNrlfR9uge0fBCamP954gZzlLtUv3p5ZmyJ6y0k4jZ
	UBTg52ajuA1bscAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718883875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVxr5+YUGGwjZxTP0c/O6rsm9IQX/jRGZRqdKqMPcXo=;
	b=h+VSl7kp1hAF9to10RA1h8Ef8cCYT1H0bttnw2DvKe2rBwnR0q46tYDQcuw9qNptihWLHN
	k3SWEQCTBJlmHf/P5r1CGyCf8O74gjNyZ2XjZx+NP7k3nsHWD9oPARYQWLScdsWxtfahV4
	WNgl4qlxgJaEm74ydv1qz3cdEtP91V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718883875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVxr5+YUGGwjZxTP0c/O6rsm9IQX/jRGZRqdKqMPcXo=;
	b=z32At5aSpGTtLUpViQ45X4VBjBDUhSJNFl/YyAMuh3r+bm5DbG3kJ2K0AKAxVXIqams08q
	8NDRYPZMH0EGPZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDE7613AC1;
	Thu, 20 Jun 2024 11:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q7EhMSMWdGbKJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 11:44:35 +0000
Date: Thu, 20 Jun 2024 13:45:01 +0200
Message-ID: <87wmmj25z6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: iwlwifi firmware regression (6.9.5 kernel, Intel AX210)
In-Reply-To: <MW5PR11MB5810E7ADB2F7AF3C7DB51EFCA3C82@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <87zfrf26bl.wl-tiwai@suse.de>
	<MW5PR11MB5810E7ADB2F7AF3C7DB51EFCA3C82@MW5PR11MB5810.namprd11.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:url]

On Thu, 20 Jun 2024 13:39:39 +0200,
Korenblit, Miriam Rachel wrote:
> 
> Hi,
> A fix was pushed to the stable tree.

Do you mean that the kernel needs a fix, instead of fixing the
firmware?

Also, could you point the corresponding commit ID on linux-stable git
tree?


thanks,

Takashi

> 
> Miri
> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, 20 June 2024 14:38
> > To: Korenblit, Miriam Rachel <miriam.rachel.korenblit@intel.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: iwlwifi firmware regression (6.9.5 kernel, Intel AX210)
> > 
> > Hi,
> > 
> > we've received a bug report from openSUSE Tumbleweed users that the latest
> > iwlwifi firmware update broke the WiFi on 6.9.x kernel:
> >   https://bugzilla.suse.com/show_bug.cgi?id=1226544
> > 
> > The package from the latest git 7d931f8afa51 is broken while the one from
> > aae8224390e2 worked.
> > 
> > Could you investigate this?
> > 
> > 
> > Thanks!
> > 
> > Takashi

