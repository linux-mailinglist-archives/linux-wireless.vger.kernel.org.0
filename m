Return-Path: <linux-wireless+bounces-36982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMttDJKZFmq1ngcAu9opvQ
	(envelope-from <linux-wireless+bounces-36982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:13:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4885E0484
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73698303276A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22943B8BC5;
	Wed, 27 May 2026 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vizG1/9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0z50Lbh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D3280A56;
	Wed, 27 May 2026 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865852; cv=none; b=uRXPjz5ADPdm1EO6G1vAfz1TMoRgtMEP+sHlG+27oXDqIZr82PoUxcb+2vANiMke0QOXQkU/f/vj1hibBmnpgfMhqsMGreOAz/69MHJDOPfzzarwiiOZ97uwNskn4Wkwr/R5UCRJA2/hmdAfxJIFF5AouodQFrixSDTZtioMFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865852; c=relaxed/simple;
	bh=DmJt5Y6l96m2qP9xliouJcupZYxCShgCClMAujDkdWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoNfdCeUsBmq38LC06XBgA5EEgZW1E9fl699U+m6i0D+yXiPy8dEE0gq+G3PnsOtkXMZyy+rmAFJFW7tSrc/Qx7play4cmhD/fl6zbNh3HOxsWlct31YEUth1/UMo4RnmBayTqkXSPNk/ZH5bsAVB3Zl/NMUteznnFskyoYaQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vizG1/9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0z50Lbh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 May 2026 09:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779865847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjlE1duJyfT159xNxaOdV8b7lVqYqn1XlbhhCUCOLoA=;
	b=1vizG1/9H8dnkoCh8INGnZf7XUJ0rZ7gbKFcFhs8NePivfShA5HwPDBTk0N8k+td3yRvpI
	JHWVocJVFBmLDyaXAVUwkkQYf7wHFPe6NYgs7DEAOLoPrSZWBu58Pa80Uvf+jPgEOuM+x8
	kh0EtxW9hStVk3wcuH0KrPmdHR/7hwVdzVRLAC5JQrf2j6WhOrL343oX37GRUgjSF5lD6G
	bgs4p0+TtFsL8dK4mODgvGoaLop6YV1XAtgSkdMD8kzwT3k7dZ+++an9qgAR3nKGBJAD9h
	KoPPkmqwX2vRGjQz4G7Xbl8bUTQOlEfkaE741qas5a+SErF3zWsGMS8WMmpoCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779865847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjlE1duJyfT159xNxaOdV8b7lVqYqn1XlbhhCUCOLoA=;
	b=Y0z50LbhtwISjkK0jpp2tIEy4F7yafYIyNnc0PnxfCpgcsxIKV5JLGIrJmBEBvFpvZ3LTH
	Yfcc/h8vUynS13Aw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Miroslav Lichvar <mlichvar@redhat.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Richard Cochran <richardcochran@gmail.com>, 
	netdev@vger.kernel.org, Rodolfo Giometti <giometti@enneenne.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Takashi Iwai <tiwai@suse.com>, Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Peter Hilber <peter.hilber@oss.qualcomm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, linux-wireless@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [patch 07/24] ptp: ptp_vmclock: Convert to
 ktime_get_snapshot_id()
Message-ID: <20260527090413-61c82c96-71f1-4f73-a9e6-cb007aa67341@linutronix.de>
References: <20260526165826.392227559@kernel.org>
 <20260526171223.223860692@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260526171223.223860692@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36982-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,redhat.com,google.com,kernel.org,linutronix.de,amazon.com,gmail.com,enneenne.com,linux.dev,lists.linux.dev,suse.com,intel.com,nvidia.com,oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B4885E0484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:14:03PM +0200, Thomas Gleixner wrote:
> ktime_get_snapshot() is replaced by ktime_get_snapshot_id() which allows to
> request a particular CLOCK ID to be captured along with the clocksource
> counter.
> 
> Convert vmclock over and use the new system_time_snapshot::sys field, which
> holds the system timestamp selected by the CLOCK ID argument.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: netdev@vger.kernel.org

Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

