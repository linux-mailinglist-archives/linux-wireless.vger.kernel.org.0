Return-Path: <linux-wireless+bounces-22200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50C6AA0C9C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3133B2B92
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27E2D026E;
	Tue, 29 Apr 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ki0qKgl6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Isbw33bq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ki0qKgl6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Isbw33bq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F92D0262
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931573; cv=none; b=nh8G27+b89SRB8aaqe/CiiRIgmRfXdoXCvYc0CjH00/RAb4sPXfdSr8Gn4zfGABtnxBNqxbekMADwGNl3GyZoijZxf2+8Mo3GpJgK9ln6AHWke/L3S6HiByNu9Oy2M5MW7NcURmmhI6qsRahiAgQzc5Xed7VB80WZYTfZ0nZYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931573; c=relaxed/simple;
	bh=MjuK/lSg2gfnEJ1nryEr/psdW7THiGFlO+Gx0Qp8XhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mltfZaibbpvB9UbdOrD+azZjAIDu2QP5B2/yaZBuD3hn3fcYj8dw80Q2YROzMFIPJfuHS/+xsXlCz5BpB5m8fdg4DPW3itFI7iULySeDM2HlYiO/lWbg+P9qAIhTKNOxB/GmFKFE5p/HsvHpkPwel2aevDv9BEC0C8/TXdo4Vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ki0qKgl6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Isbw33bq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ki0qKgl6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Isbw33bq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72A3B1F391;
	Tue, 29 Apr 2025 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745931569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOpr0MmnZWLYeA72wI88/nqcTraiGo+BD0i31sE7Rtk=;
	b=ki0qKgl6E5qcsG1lSg71g7+Tyz+w7icENL7VGX9dvDqjqqCWqmQQ7+XBm2SqNurWze4Y7z
	vIOY+mrDeRMKjSLPlWviVq4M1BD9aG4O/rSza7Okfoizn1y5BBd5ZC48CZ+2yGBFwYLRm3
	pbcRfyDpjWxj+s/EGP+UMJayNJloCcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745931569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOpr0MmnZWLYeA72wI88/nqcTraiGo+BD0i31sE7Rtk=;
	b=Isbw33bq03+GreuAyzjBgP//PNMMUsFH2Vs3D6nYe0a0/8cKidwMg+4/w/S3dzdoIyB5Ys
	+os3INoVfkjjugDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745931569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOpr0MmnZWLYeA72wI88/nqcTraiGo+BD0i31sE7Rtk=;
	b=ki0qKgl6E5qcsG1lSg71g7+Tyz+w7icENL7VGX9dvDqjqqCWqmQQ7+XBm2SqNurWze4Y7z
	vIOY+mrDeRMKjSLPlWviVq4M1BD9aG4O/rSza7Okfoizn1y5BBd5ZC48CZ+2yGBFwYLRm3
	pbcRfyDpjWxj+s/EGP+UMJayNJloCcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745931569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LOpr0MmnZWLYeA72wI88/nqcTraiGo+BD0i31sE7Rtk=;
	b=Isbw33bq03+GreuAyzjBgP//PNMMUsFH2Vs3D6nYe0a0/8cKidwMg+4/w/S3dzdoIyB5Ys
	+os3INoVfkjjugDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 533481340C;
	Tue, 29 Apr 2025 12:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 09D4ETHNEGhaYAAAD6G6ig
	(envelope-from <iivanov@suse.de>); Tue, 29 Apr 2025 12:59:29 +0000
Date: Tue, 29 Apr 2025 15:59:28 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Jeff Chen <jeff.chen_1@nxp.com>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 0/4] wifi: mwifiex: add iw61x support
Message-ID: <20250429125928.pw7k4raw52jyvyaj@localhost.localdomain>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250331065026.GA12444@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331065026.GA12444@francesco-nb>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On 03-31 08:50, Francesco Dolcini wrote:
> Message-ID: <20250331065026.GA12444@francesco-nb>
> 
> +Pete/Jesse @NXP
> 
> On Wed, Mar 26, 2025 at 01:18:30PM +0100, Sascha Hauer wrote:
> > This series adds iw61x support to the mwifiex driver. It works for me,
> > but is not yet ready to be merged. Some people showed interest in it, so
> > I am sending it here.
> > 
> > All testing and review feedback appreciated.
> > 
> > During startup I get these messages:
> > 
> > [   12.078010] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
> > [   12.078018] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
> > [   12.078024] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x23e

In the downstream driver, branch lf-6.12.3_1.0.0, t his seems to be
MrvlIEtypes_fw_cap_info_t for things like:

FW_CAPINFO_EXT_802_11AX, FW_CAPINFO_EXT_6G ....

> > [   12.078029] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x25c
> > 

This looks like MrvlIEtypes_Secure_Boot_Uuid_t. Doesn't seems too
important.

> > Not sure what these are about, I can't see these handled in the
> > downstream mwifiex driver as well. Could also be there is some parsing
> > error. Nevertheless the driver seems to work.

Yep, it is working. Thank you! I am testing this on FRDM-iMX93, which has
IW612 revision 1.0.

I have to use nxp/sd_w61x_v1.bin.se on this board and NULL firmware_sdiouart
because it seems that firmware return 1 as "strap" value, even if WiFi
is definitely connected over SDIO.

Regards,
Ivan


