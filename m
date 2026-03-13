Return-Path: <linux-wireless+bounces-33207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEfMEP73s2nYdgAAu9opvQ
	(envelope-from <linux-wireless+bounces-33207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:41:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634E282614
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D43C3023D57
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE172BEFF5;
	Fri, 13 Mar 2026 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mFnCwHDZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22731F9A3;
	Fri, 13 Mar 2026 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402108; cv=none; b=fQqeTEJPKqi7bpYdzqrHXr7Pg2wUHBBPjcJuOFvDnBZt8Cx1U+3E4iD5hKGDYLzs2TbgwmDdeZNpARdp0unT+siqkO/rCsRb2h3754tP1FaKewIYLM0ynNITmHGBsEsfb4eJPC0xyRdtfBGk++Vz6lz1ExI/peXy4w4gCubmTi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402108; c=relaxed/simple;
	bh=TU2dnZCFJnzItZXhQ43SvXNzEc9yF6HBvQGj7srjLUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+MDFvQHPZxdDISwNF5OnThwdf+F7/2VFzgU1d3ZSjpySeW7LfgF9nBzF+MSAE1MIAtVkCE10LKQ3FESvUbR2wkxoN1s/pkK7mSZ7nTt/1S33hxpWtim5pqmBIqneY5e5lf1jZ4gz5F+uVD+k0F++qd9aIFo15+DSJGZkvgRvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mFnCwHDZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Iv7FxOX3IBJtcvpWoXa8+p43bf5NruA7K/0HI9888hY=;
	t=1773402107; x=1774611707; b=mFnCwHDZt/QRacu/DYfr4Hr/6q5X3E3RFq/x/RO4/IkH9A+
	5vWXrD1hUbiMDNpFL2X2h1pdpWzKNRJc4oKsHmf7dsLwxSsE/9YbgoMfeXuGjAQAYGDPEsauFVjz/
	fPnhU3iJSg3zXMzm1pOu5tRkLxgaRmExP0wG23oLUXxCKw6f1YrRuMv3H2aUnNgVvGH2gqO8FXFvN
	4OtvOz3OHixrzM0Rcn/1GnJaGrXaNg7ZDMe02PgReoDdFgdics3MKnSdIIy2sP8Ko/iaajSHPGq2V
	WOfRWgZ5fpV9pG74anqGE3r1UGzEi/Xnm69Xk+Sx9BFA8vpTZsBSrT2pNp6IdGkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w10tk-0000000GuL6-3Vnt;
	Fri, 13 Mar 2026 12:41:45 +0100
Message-ID: <5c3316154428c85511c493e42f72706f551404cf.camel@sipsolutions.net>
Subject: Re: [syzbot ci] Re: misc chandef cleanups
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: syzbot ci <syzbot+ci0f91523e1d0ef709@syzkaller.appspotmail.com>, 
	arien.judge@morsemicro.com, linux-wireless@vger.kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Fri, 13 Mar 2026 12:41:44 +0100
In-Reply-To: <sezz36jv4edclmbtrcbdwzyb5goxp2tcfneoi56ounzuled42v@o6bajqutzp33> (sfid-20260313_104859_859229_E5B7116D)
References: <69b3ce9d.050a0220.12d28.010d.GAE@google.com>
	 <855780e1bece0de480b7fd3e1cf67c9f70129818.camel@sipsolutions.net>
	 <sezz36jv4edclmbtrcbdwzyb5goxp2tcfneoi56ounzuled42v@o6bajqutzp33>
	 (sfid-20260313_104859_859229_E5B7116D)
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33207-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ci0f91523e1d0ef709];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 0634E282614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-13 at 20:48 +1100, Lachlan Hodges wrote:
>=20
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index 3e867930e253..7314312ec567 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -3634,8 +3634,6 @@ static int _nl80211_parse_chandef(struct cfg80211=
_registered_device *rdev,
> >  		case NL80211_CHAN_HT20:
> >  		case NL80211_CHAN_HT40PLUS:
> >  		case NL80211_CHAN_HT40MINUS:
> > -			cfg80211_chandef_create(chandef, chandef->chan,
> > -						chantype);
> >  			/* user input for center_freq is incorrect */
> >  			if (attrs[NL80211_ATTR_CENTER_FREQ1] &&
> >  			    chandef->center_freq1 !=3D nla_get_u32(attrs[NL80211_ATTR_CENTE=
R_FREQ1])) {
> > @@ -3652,6 +3650,11 @@ static int _nl80211_parse_chandef(struct cfg8021=
1_registered_device *rdev,
> >  						    "center frequency 2 can't be used");
> >  				return -EINVAL;
> >  			}
> > +			if (chandef->chan->band =3D=3D NL80211_BAND_60GHZ ||
> > +			    chandef->chan->band =3D=3D NL80211_BAND_S1GHZ)
> > +				return -EINVAL;
> > +			cfg80211_chandef_create(chandef, chandef->chan,
> > +						chantype);
> >  			break;
> >  		default:
> >  			NL_SET_ERR_MSG_ATTR(extack,
> >=20
> >=20
> > I think?
>=20
> I'm probably misunderstanding - but cfg80211_chandef_create() modifies
> chandef->center_freq1 if you have a HT40+/- chantype wouldn't you
> wanna do that before you validate against the CENTER_FREQ1 attribute?

Oh, yeah, oops.

> Since in the generic init code above it sets cf1 to the control freq?
>=20
> [...]
> chandef->center_freq1 =3D KHZ_TO_MHZ(control_freq);
> [...]
>=20
> where it wouldn't match for HT40-/+ since im guessing the CF1 sent
> down should be what it would be _after_ being set by
> cfg80211_create_chandef() based on the chantype? Or am i missing
> something?

No, I just didn't think about it. I moved it because I thought I'd do
this differently, but this validation can just come first anyway.

johannes

