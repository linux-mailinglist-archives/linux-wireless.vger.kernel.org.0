Return-Path: <linux-wireless+bounces-33659-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOCnF7odv2mavAMAu9opvQ
	(envelope-from <linux-wireless+bounces-33659-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:37:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CAF2E77F3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 23:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADDE7300DF4D
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A829B793;
	Sat, 21 Mar 2026 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uvhjkTFa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F67282F0B
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774132646; cv=none; b=BQy1oYAha9wa56XmziCJowhxo4sN4/2fjT1MY0npFVSR8ZMxf5v2SzaCUyhlzhsTfaUBAXRmVOZ1+FzLlJxWaHeA4Tvj4vex/k05DOnVn9UAzWu3QvXiqJFT0jOHYkQ2U6dc85TwE8iiy/XdT3K2s1XHmjVq/ysZyCpInHPn11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774132646; c=relaxed/simple;
	bh=Bu/dOxuGpgan0gVJpXUKdYnZnMAFHXN95DLlIufj8Jo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MsWuFQXUhXAldrBaDZj/3MyGrVWrT8rzm4uJZb4cIv/5YHPFMPPYUhchFLwzuJbTMtsNTt4mbnGufDuq9dWXzCKCnkAPmBFaJL1S9YtKrNSM5UMYL4c6bcqP5eUb7Rcv91ZFdQ94wAaFM17Hck8dVMfGPLBZHvW8vkSwAPVT7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uvhjkTFa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ycJFp9TwqNlqxtaXvfuZJuB+1FImsEFLXlJLabYA1cE=;
	t=1774132645; x=1775342245; b=uvhjkTFasTypWrNCVu4E9bQTnpuGMIww2oczK316/QuCJqL
	uP0wRZsPpT9NuBsHBUeYPZSkqw2o3Ivf5hIdwowiK9nscAupnPI/iAt5l236749eVIFyvbOeWuuSS
	uQ2AU80+auVerC2sGSUiOk4UhnbxBZdlFW4WV7OCVT29xI24j7lyl8w6JHcLe8nZbsdAYtGrcq+Uy
	//P804ZHtoBq1xWF56YOTiAH4xUcGETqYXFw6IafqWEWR7672DAIlGYEqkF/s3L8yKQzLs09ETFkj
	iyflMOLTQCOJhckNANaTSgt1P5jTBHEL8k8G2LuIN4agiuBvu2ujSWeEAkDRNTzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w44wV-0000000811Q-2vAl;
	Sat, 21 Mar 2026 23:37:16 +0100
Message-ID: <7f9e4e4409f8406ec70a80441d049c5f6c6958fa.camel@sipsolutions.net>
Subject: Re: [PATCH 13/16] carl9170: rx: gate data frame delivery on STARTED
 state
From: Johannes Berg <johannes@sipsolutions.net>
To: Christian Lamparter <chunkeey@gmail.com>, Masi Osmani <mas-i@hotmail.de>
Cc: linux-wireless@vger.kernel.org
Date: Sat, 21 Mar 2026 23:37:14 +0100
In-Reply-To: <17fe2464-e8a1-4f2b-a024-a78bcf460bcd@gmail.com>
References: 
	<AM7PPF5613FA0B6ADFF8016B03CAA1A9DEB9441A@AM7PPF5613FA0B6.EURP251.PROD.OUTLOOK.COM>
	 <17fe2464-e8a1-4f2b-a024-a78bcf460bcd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33659-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,hotmail.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hotmail.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7CAF2E77F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-03-21 at 23:34 +0100, Christian Lamparter wrote:
> On 3/17/26 12:06 PM, Masi Osmani wrote:
> > Do not deliver data frames to mac80211 unless the device is fully
> > started.  After carl9170_op_stop() the driver state drops to IDLE,
> > but the USB RX path can still receive frames from the hardware.
> > Without this gate, ieee80211_rx() may reference station data that
> > sta_info_destroy_part2() is concurrently freeing during interface
> > teardown, causing a use-after-free kernel panic.
> >=20
> > The race occurs when ieee80211_handle_reconfig_failure() clears
> > IN_DRIVER flags without stopping the hardware: cfg80211 then tears
> > down interfaces via ieee80211_do_stop() which calls sta_info_flush()
> > while the driver's RX path still delivers frames.  This was observed
> > when carl9170 firmware deadlocks during a restart attempt and
> > ieee80211_reconfig() fails at drv_add_interface().
> >=20
> > The gate is placed in carl9170_rx_untie_data() just before the
> > ieee80211_rx() call, not in the USB layer, because firmware command
> > responses (including CARL9170_RSP_BOOT needed for firmware upload)
> > must still flow through the shared RX path via
> > carl9170_handle_command_response() which returns before reaching
> > this point.
> >=20
> > Signed-off-by: Masi Osmani <mas-i@hotmail.de>
> > ---
> >   drivers/net/wireless/ath/carl9170/rx.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >=20
> > diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wirel=
ess/ath/carl9170/rx.c
> > index 683343013..19c6bd418 100644
> > --- a/drivers/net/wireless/ath/carl9170/rx.c
> > +++ b/drivers/net/wireless/ath/carl9170/rx.c
> > @@ -676,6 +676,14 @@ static int carl9170_handle_mpdu(struct ar9170 *ar,=
 u8 *buf, int len,
> >  =20
> >   	carl9170_ba_check(ar, buf, len);
> >  =20
> > +	/*
> > +	 * Do not deliver data frames to mac80211 unless the device is
> > +	 * fully started.  After carl9170_op_stop() the state drops to
> > +	 * IDLE, preventing a use-after-free when sta_info_destroy_part2()
> > +	 * races with ieee80211_rx() during interface teardown.
> > +	 */
>=20
> If what you write is true for an up-to-date kernel, this needs to be addr=
essed in mac80211.
> Under no circumstance should mac80211 behave that way... for any driver, =
in any case.
>=20
> Can you please post the panics/errors/warnings?

Yeah, this whole use-after-free is super fishy since we have RCU for it
all. Masi proposed a patch to mac80211 with similar strange reasoning
which I rejected, and never provided the errors that were happening ...

johannes

