Return-Path: <linux-wireless+bounces-32982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A9hCY1LsWlCtAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:01:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB07262AF4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD78307B55A
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86E3D47B6;
	Wed, 11 Mar 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XCBKV3oh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6131F875A
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226601; cv=none; b=oTH+5vbai8MNlb3deHsp0lWyY89fh9GmlA3iHqOjJhC7Xnrbv9B8Piyrj2LhVnko942r8wu1B2mlLGV2geBhEiTBhKQWHvdeMqA47PDNU8e8Qol569i1BCeuxnR8p99FN/2lKL9/l+VVdvuXYqAhG67/Gsl8AMO+84fMTdvTKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226601; c=relaxed/simple;
	bh=5PugBFKZji+CdK0QvxTnwCvJ0k5CeaH0k9ZK6Q3VGLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0BScjUG7Ez5k/gyuqG06voPfJ39OhyjmosxaVKaNE+xXc7EsNPuKcZoreOxaPSCXx5XEE88GnRE2zXIUm17Dlt2jBAHSAcNqrNMnVi+aGEN2cp02dOcaLQLmlOXR8aw4G9iKUuDgCbMwnKLRERPCy5NfGimnk4zKNDZsd312aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XCBKV3oh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7AIu2CbUwA3EFNazXWfQajA59owSx0UhFpAVg3xWYiM=;
	t=1773226600; x=1774436200; b=XCBKV3oh6UN/ucrse3fBdTePGnkAYESlAXKfM36GBfG7LkN
	fm0JRcQGW+no4WBpWAoOEr82UpY58apxy2wxjReqgAbJMsD0++AmKS7y/lqgtOU6FEQ60OiqhxfuK
	toknRPd/pxd7/GbSS29pxL/+7raUpTsEPtPrfxE8CplHmFDFMu3wvJNB6xB6vZbI/Fh8eWNoDPd2V
	sDKqn89PcV9FMtoMRPZBsaTC4pw5a9IltiXA/Y3viijsUqaxYusKGEBqSyF90E9HT6DmIoT7glvw3
	lXOMuK4drSE35AFMEMdvNDiKB1RVV/Gbb4jxxqMsxiTMaX37RJCTrIdiYKs/pA3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w0HF0-0000000EoiY-1Xn4;
	Wed, 11 Mar 2026 11:56:38 +0100
Message-ID: <b725c0be05df1a9595c177aada4cc148bf555448.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: init S1G properly when
 creating chandef
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 11 Mar 2026 11:56:37 +0100
In-Reply-To: <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c> (sfid-20260311_112148_368557_B2317140)
References: <20260311064339.524758-1-lachlan.hodges@morsemicro.com>
	 <791eaf8ab04dcbe01e2d71612d162f71c61e573a.camel@sipsolutions.net>
	 <4dhrrbuvxdgve2doc7qvabzjancimtqpounngyrxspk4d4rbls@xnad5bwciz7c>
	 (sfid-20260311_112148_368557_B2317140)
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
X-Rspamd-Queue-Id: 1BB07262AF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32982-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,morsemicro.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 2026-03-11 at 21:21 +1100, Lachlan Hodges wrote:
> On Wed, Mar 11, 2026 at 10:55:46AM +0100, Johannes Berg wrote:
> > On Wed, 2026-03-11 at 17:43 +1100, Lachlan Hodges wrote:
> > > When creating a chandef, the initial width is determined by the
> > > chan_type argument leading to a default width of 20/20_NOHT/40 which
> > > does not make sense for S1G channels. Fix this by ensuring we default
> > > S1G chandefs to a width of 1MHz.
> > >=20
> > > Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> > > ---
> > > v1 -> v2:
> > >=20
> > > - Remove the mac80211-based wording in the commit message and keep it
> > >   simple.
> >=20
> > Thanks :)
> >=20
> > Now with more tea and all that, do we really want it to completely
> > ignore the width? Should that be documented? Almost feels like it shoul=
d
> > WARN if you use it wrong, with an S1G channel but a regular width, and
> > mac80211 should be fixed?
> =20
> When you say "ignore the width"=C2=A0

Sorry, I meant the channel type (chantype argument).

> do you mean nothing checks it?

I meant for s1g the chantype argument would be ignored now, not that it
wasn't checked.

> If
> that's the case we probably need to add something within
> cfg80211_chandef_valid() to ensure if we have an S1G chan we don't
> have a non-S1G width i.e > 16MHz. That would fix mac80211 from
> giving it to the driver in the first place.

We don't have that? Seems like an oversight too, but I was thinking like
this (overall changes, not split to commits), since
cfg80211_chandef_create() really doesn't work for S1G since the chantype
is 20MHz-non-HT, 20MHz-HT, HT40+ or HT40-.


diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b0451f1c8e79..9a055dfb445a 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1118,6 +1118,19 @@ ieee80211_ifcomb_check(const struct ieee80211_iface_=
combination *c, int n_comb)
 	return true;
 }
=20
+static void ieee80211_create_default_chandef(struct cfg80211_chan_def *cha=
ndef,
+					     struct ieee80211_channel *chan)
+{
+	*chandef =3D (struct cfg80211_chan_def) {
+		.chan =3D chan,
+		.width =3D chan->band =3D=3D NL80211_BAND_S1GHZ ?
+			NL80211_CHAN_WIDTH_1 :
+			NL80211_CHAN_WIDTH_20_NOHT,
+		.center_freq1 =3D chan->center_freq,
+		.freq1_offset =3D chan->freq_offset,
+	}
+}
+
 int ieee80211_register_hw(struct ieee80211_hw *hw)
 {
 	struct ieee80211_local *local =3D hw_to_local(hw);
@@ -1261,9 +1274,8 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			/* if none found then use the first anyway */
 			if (i =3D=3D sband->n_channels)
 				i =3D 0;
-			cfg80211_chandef_create(&dflt_chandef,
-						&sband->channels[i],
-						NL80211_CHAN_NO_HT);
+			ieee80211_create_default_chandef(&dflt_chandef,
+							 &sband->channels[i]);
 			/* init channel we're on */
 			local->monitor_chanreq.oper =3D dflt_chandef;
 			if (local->emulate_chanctx) {
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index d9d4e043bb39..4ae2f6ca0378 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -29,9 +29,10 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *c=
handef,
=20
 	*chandef =3D (struct cfg80211_chan_def) {
 		.chan =3D chan,
-		.freq1_offset =3D chan->freq_offset,
 	};
=20
+	WARN_ON(chan->band =3D=3D NL80211_BAND_S1GHZ);
+
 	switch (chan_type) {
 	case NL80211_CHAN_NO_HT:
 		chandef->width =3D NL80211_CHAN_WIDTH_20_NOHT;


johannes

