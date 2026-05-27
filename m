Return-Path: <linux-wireless+bounces-36987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHJBEl+cFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:25:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C975A5E06B9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BC65300EA9D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4893B9DBC;
	Wed, 27 May 2026 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FkUpssg0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ieFBt9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC9027E07E;
	Wed, 27 May 2026 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866647; cv=none; b=ZLpIzwI/qRyAsEUPHlQVxd9jHVozcULDUz6WhppToSbxKtzuQTprUmNWdvm0x3UWpw/YvcyYU/wnKrvzb78e6zELaDTF0uyyE7+suoxGDL/4P4nhdWIDFL6AVfSdGcPDi8hQJDsyE7X0fxF8Eqs99tm83w29+pmKxCurc7F8u1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866647; c=relaxed/simple;
	bh=0GxrnqQsIHJc8/J+DP1bS3pmMDSfVWm/u3woTGgTiFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blM4lLk7nEBSavsRHy/e3GVll0h4OTlc5NmrryYMf8OC5dzFEyhhjRWCxDTflQNUvfXrK7x+Vl4MsefM0EDgUalWi15Atx7SKbdH4KupMwd8yyuetIqu3nl3KGsUmJXDUmin0x7SAUM0sp9UPJ0N+bXNfoprnX3umGSCl1lQblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FkUpssg0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ieFBt9b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 09:24:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779866644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AVU5O6TgmuWWOaBdgRI1qBQhdd7wOoQDtWUb/vv/iY=;
	b=FkUpssg02Bo4V1Ml5s8QmIijbzYG6l87XQSDgkRTRT5GbI2zqg/UQmpqYlbYhIQTxLDoE4
	qctvH85qCjdmvY1f+MiE028ufQZvGyXSGjOf5d81PBXISybg4vab44zYbTYQG3l4IExubl
	Ic2yLckd0zczOvLm4dZFkuaphDWgCCRCG/sxdVt4yOequeXb5nkHMCAam7jTOTME+xjqiN
	GH0m789nUbc084KF95OvJXMtXbwA/G0IIOUhcyZX4/sPaP9Z7MdLsIRQ+JdSFd7voC5CyE
	xu8eHr1cbV4xVZZznuScEpp+PjOyGNrkreRwWvYmvz2dwH9KMnPqVHXBgZgV6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779866644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AVU5O6TgmuWWOaBdgRI1qBQhdd7wOoQDtWUb/vv/iY=;
	b=1ieFBt9bdGW/l6CD21ilqEOxlMlYMAHGDZhPjg0Omknq9Rwf7GYn52K/v6UyX0AFmutzCh
	Y/vWq6+pe5YlVtBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Rodolfo Giometti <giometti@enneenne.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Peter Hilber <peter.hilber@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, linux-wireless@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [patch 22/24] timekeeping: Remove
 system_device_crosststamp::sys_realtime
Message-ID: <20260527092342-c43f1e40-38e5-443c-a10c-c553d1c0a47f@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171224.347997043@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171224.347997043@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36987-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: C975A5E06B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:15:17PM +0200, Thomas Gleixner wrote:
> All users are converted to sys_systime.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

