Return-Path: <linux-wireless+bounces-23526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B24ACAA2A
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB45718968FD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AED1AC891;
	Mon,  2 Jun 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UvaTck64"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D392C3255
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748850947; cv=none; b=nu27w8A/0vSm8kgYiA9EH3s14UTPvY4fvTGkKYV8PgdITtRabnp4q+OU2P4K6MxEE2/0dpexqpGdlayrcS6rISGWePEnyeWlEz9v/J50kZ9odPT59+qhoIpJGnVoUCuYvKEZUBWYwk7oRdthm71wRokU5HA9kjZb1kh8H5SvWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748850947; c=relaxed/simple;
	bh=EbfgoTJBucPhEKdKUnB9UmcxpewYUWcc+UhU8u6viA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcFNqLrMLCsy4G0srWE6ZDyqXstIMfE4VBxa8sqsLcsSdLlQD7gQu4UqQqEju8Ubyv8ZXHBh7yPCUk7rf9XqnGYUyfWCxjfE63fOunXiBgo434iYd7Efnngi6eLQrc22JkEQAQgQgKdMJuXh4CjQZds9i2qW62xXmjy7yHSF7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UvaTck64; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CeK6BUTaIU9dHP9PVFBXJG3iA4MMsMdovpaXH2r0Q14=;
	t=1748850946; x=1750060546; b=UvaTck64eSFy66mmwySNFGj+cN0TegfkTAqr7vnlSUCMLdO
	JMNQ07xOxFGRL0thGnDmRD7jO8ENN1Lwaf+GWJOFr0nbGWQRO7HDkRODozqDQ9zMdXwwnVehLKzWY
	/r77e11oqEV0HI4ywE7XxZo+di6uLf6VugfXsodb+xgN6/vQzqzR/5iBSqDzfWw0vRQMISLgkGjz+
	1WdEUsP+e7xTNEitHzXwfTnfbsclxe+vWO3j3KCxhS9uWBPXJa2+PTfWpJn/bPD0r4jLhhixMHHMJ
	4Z+RHu90ukLl4UpZv2F2K+0ZWPBYDKsQbAzITQsEE8YxSonDv8/aOgkHnCUthPEw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uM01A-00000004mMQ-2ICT;
	Mon, 02 Jun 2025 09:55:36 +0200
Message-ID: <27f4b77b27b42c5eb50fadc2c8b425e5236bf118.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v11 3/3] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Roopni Devanathan
	 <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 02 Jun 2025 09:55:35 +0200
In-Reply-To: <908067d3-87cf-4477-959e-0dd738244d88@oss.qualcomm.com>
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
	 <20250522053326.4139256-4-quic_rdevanat@quicinc.com>
	 <e5c0fa7c-598f-40d8-b258-f935af069ff3@oss.qualcomm.com>
	 <b37db169-22a6-48fb-9183-f2ed970bdd32@quicinc.com>
	 <908067d3-87cf-4477-959e-0dd738244d88@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-05-29 at 08:36 -0700, Jeff Johnson wrote:
>=20
> > > > +++ b/include/net/mac80211.h
> > > > @@ -4572,7 +4572,8 @@ struct ieee80211_ops {
> > > >  			    struct ieee80211_key_conf *key,
> > > >  			    struct ieee80211_key_seq *seq);
> > > >  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
> > > > -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
> > > > +	int (*set_rts_threshold)(struct ieee80211_hw *hw, int radio_id,
> > > > +				 u32 value);
> > > >  	int (*sta_add)(struct ieee80211_hw *hw, struct ieee80211_vif *vif=
,
> > > >  		       struct ieee80211_sta *sta);
> > > >  	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *=
vif,
> > >=20
> > > rather than have one patch that modifies the get_rts_threshold API, a=
nother
> > > that modifies the set_rts_threshold API, and future ones that will mo=
dify
> > > others, should we put these interface changes that affect all drivers=
 in a
> > > single patch so that the individual driver maintainers only have to d=
eal with
> > > this disruption once rather than for each attribute?


> > If we are going to change the interfaces of all the handlers of these
> > attributes, I can assign a default radio_idx (-1) to all the APIs. Can =
I go
> > ahead implementing this?
>=20
> That makes sense to me. Johannes?

I don't really see a huge advantage, given that I'm going to apply those
patches either way? Do you think conflicts are likely? But if you prefer
we can do it that way, then just should separate out those changes to
completely non-functional patch (i.e. please don't mix actually changing
the RTS threshold in this patch with API updates for the others, do API
updates for all beforehand.)

johannes

