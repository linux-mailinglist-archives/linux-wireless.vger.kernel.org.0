Return-Path: <linux-wireless+bounces-38660-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AzMCMk52S2pkRwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38660-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:33:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8370EA22
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 11:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=xEzvHrmZ;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=WP2PNLca;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38660-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38660-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33CA0303746A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D13F8234;
	Mon,  6 Jul 2026 08:42:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A93FD159;
	Mon,  6 Jul 2026 08:42:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327358; cv=none; b=o3HYj2gNVbmZI/lajffEs3eitewEnRbFdrTKg42oN9uKp2I+SRULhYE3dF0Hctcg7Vd2mGfQ9+otOcc4jLBE7URAz5K5nw9GOPNsRb50Scdkm6vyE3v4Zs4xI9e5yAQ8WS7wrTWcR7O6BYSW3PRpk3fzZnyzc/PLnvubnjTcXE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327358; c=relaxed/simple;
	bh=O4q3m9twkSC1QC9V2DeWjMZQFNL1nKCZpNAoTTNPdOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISkT6wZ5EB6xybIOv75GWN+0aHCc4E8f9pBe4ZgltyQVg40W+BMUPB8+j3O8sycNtzlDbY0POQKjIa1kcmGhGG5weqfdX+FBk1Iqya1A0XrYhFc1PonoLtDbmukvqYQb7QE+KHGTDdSAOHvSCpM0vuBXBzmEy9jPulMwcsYzelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xEzvHrmZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WP2PNLca; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 6 Jul 2026 10:42:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783327343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx2JGNYXzBQVck8nCP9EIoLDc9txtLOxBCkElVT+408=;
	b=xEzvHrmZJIRJyRrBqvbshSnu52HLO8ue8Vule+sdKx2uzfp/swOjBcFZij3UNweaE1G/20
	iQ+YRVGQVQjwEJe1zh/TkaQwkUYmsRf1sVT0aK1MhpgsJoC+pR+9i0SAG/qKDpmtjOFjTW
	3TdvXuzMlmQDZSKFytMF2yHJOF1NVAi0hyVA6/7ajcjgeCxpSS0AVaU+v7kpIWZkR8/kPu
	wAS9EELIqgox5PuZUG2CiNi8DW2fu/1Qv2hV4lrwYX7p/yLERy6dI+vkLAfEWV9IxDRsyc
	j1QgJKor7fn4iVERFkYHh+WT8XfJ5iXnmnlJJGAZxafJ8jFTc613xHO4Ye02Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783327343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx2JGNYXzBQVck8nCP9EIoLDc9txtLOxBCkElVT+408=;
	b=WP2PNLcaTAzB3qA0iJOv8D8ZDx9jJzYzqtcHxwOwZT1TRFIs2jwW5FFQ9ljELht+FYSHYO
	GfjT2OyA72zsvuBA==
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
Subject: Re: [PATCH] timekeeping: Document monotonic raw timestamps in
 snapshots correctly
Message-ID: <20260706081734-32262bc9-5dcd-401c-bd47-18b91636bf73@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.374814973@kernel.org>
 <20260626103359-66ab2b54-d36f-416b-94a4-3f3708dccced@linutronix.de>
 <87echtk24a.ffs@fw13>
 <20260626125819-d8b197fc-7671-4d12-a578-9025affc52d9@linutronix.de>
 <87fr29ib4v.ffs@fw13>
 <20260629055344-b74c43de-2a2b-4608-ae4e-ed0ac8e12fd1@linutronix.de>
 <87bjctsptt.ffs@fw13>
 <87wlv9k3wz.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wlv9k3wz.ffs@fw13>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38660-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:mlichvar@redhat.com,m:jstultz@google.com,m:sboyd@kernel.org,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:akiyano@amazon.com,m:giometti@enneenne.com,m:vdonnefort@google.com,m:maz@kernel.org,m:oliver.upton@linux.dev,m:kvmarm@lists.linux.dev,m:oupton@kernel.org,m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:tiwai@suse.com,m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:saeedm@nvidia.com,m:peter.hilber@oss.qualcomm.com,m:mst@redhat.com,m:virtualization@lists.linux.dev,m:linux-wireless@vger.kernel.org,m:linux-sound@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,enneenne.com,linux.dev,lists.linux.dev,gmail.com,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AF8370EA22

On Sun, Jul 05, 2026 at 02:38:04PM +0200, Thomas Gleixner wrote:
> The comments related to raw monotonic timestamps for the various
> snapshot mechanisms in code and struct documentation are ambiguous. They
> reference them as CLOCK_MONOTONIC_RAW timestamps, but with the arrival
> of AUX clocks that's not longer correct.
> 
> The raw monotonic timestamps only represent CLOCK_MONOTONIC_RAW for the
> system time clock IDs, i.e. REALTIME, MONOTONIC, BOOTTIME, TAI.
> 
> For AUX clocks they refer to the monotonic raw clock which is related to
> the individual AUX clocks. These monotonic raw timestamps have the same
> conversion factor as CLOCK_MONOTONIC_RAW, but differ from that by an
> offset:
> 
> 	MONORAW(AUX$N) = MONORAW(SYSTEM) + OFFSET(AUX$N)
> 
> The offset is established when a AUX clock is enabled and stays constant
> for the lifetime of the AUX clock.
> 
> Update the comments so they reflect reality.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Reported-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Thanks!

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

(...)

