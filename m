Return-Path: <linux-wireless+bounces-35271-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MjSDkhf62lGLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35271-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:17:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9245E49D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC27300D45E
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5573C3C1E;
	Fri, 24 Apr 2026 12:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="jjW6slul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSmERdS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523A3C5DC3;
	Fri, 24 Apr 2026 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033026; cv=none; b=ZsrWTBjOjw5mPoBp1ldnwhz1ua7rIULKKfywupm6Kk8wKMprr4joIoICNzmRwnMm/PMN+IwdUnVbq2yUgvS19fCZlSfvnrZA26vd5q0D7yGgCf5ZmA0FKASuvqWwO+SmkApd3Uv0lfUvTo3kx4qbcGvLZoJcqmXbAVyGxVvn44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033026; c=relaxed/simple;
	bh=p3waIAl630iRszEnJiKjXUzSHcUGwn9r0UxnN/sOVNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adrUomS02MosRS/atOev+EYG1cCQrm90dlKYeDDKCjhU+tYC2DnfvUH5oPMbIqNArSPH6Vi0UQuttr6RQOke6k2cDhbe2EPx+11W2fsfFW8jQZ/5oQI9w14jV5mFL+ALHYxAaR1hSfKy1UtxU2kp6d2Gzaila9UBk46ou6aw6a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=jjW6slul; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSmERdS0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CA057EC0534;
	Fri, 24 Apr 2026 08:17:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 24 Apr 2026 08:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777033021; x=1777119421; bh=ux5cqlt4IM
	80vxhXkNBd6OQ3EP72rkh1zYIAaIFNIkU=; b=jjW6slullV9r/3hYNmf9Xjoi+7
	c+rSkX+wUDNRIGDUjKLnRt1iDKERhOiUttYgSd+F7q4SUfS0pBm6vGgVjCnNAFlU
	S9XFlki9qlDAoF2sL1cFezMOm9wZ4tZliYDogbdpy/b2EyTKdqZOVfNHSKuCzAoU
	vWYMDtUrwLNHaxfCJFkINAHAgJN62MhJquZeJkUzio6wr4JowHhj6yxA9aiB4mHt
	7KTKqlXF9C2j9MYKIeTr7k6u9MfSuU8xOdbFksfgDs3kgSKPbPkUgUJRSNoDhYcU
	8x5nQ2yBxHFBIh0tEdnxUhPJoboD7Ldpw9AjM5Fs691US5z2OfPDDnpc8sag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777033021; x=1777119421; bh=ux5cqlt4IM80vxhXkNBd6OQ3EP72rkh1zYI
	AaIFNIkU=; b=SSmERdS0QpAIXWKHxjOapRlf/85qFBj+AOoV461Lp0UJfOPfGB1
	zIQ0a763AcCEHfNFcb5J1BdaE+VQZjgiF/Bpn97IQc+48NL2AnysMk7VHNElUROW
	qaLfDId2LPRjOrhIKjVu/wbSCX2FNNC3hZ0GtC31FKwv/co9Yizxc3fsOo9aYZMx
	Z505pcFYBu3KlCuY2zLjzg7s1bvAB+OH6RNLX3NQdFG7tLcRFSly80SG8FezmhT8
	ZvdJVqyo0xuIvNQimzVDTNzTT3fiDlZ+GTOcuuYhRNCOMu0XGOSvBNP+MbAV83pS
	42UbRFQiEf2hEwzF4kdvXRKX2zAv3YvFWyw==
X-ME-Sender: <xms:PV_rabVJx7Ci6-KR5YD1v3_0aIk-sSee-322LAWY0epGEOUwZ90CPQ>
    <xme:PV_raTAkVlXXaLdQuzA_TGenR-GEH6wgodunWSYyo_yam3Qx_srrcLTQDrydXNQQL
    3t4xzpW5YGz7MpUUdSqnw0Qm8FOYjpAJyLAylEZv-Vt74elcw>
X-ME-Received: <xmr:PV_raYeNm0pWV5qqcAo2tFJKamog6mpPPdan8s_PKlD_i-waW1opnENDncLYQfrd1ljisxOggh7NqVimDSwpxKXiLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsrhhithgvrdgrihhrghgvugguohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hohhgrnhhnvghssehsihhpshholhhuthhiohhnshdrnhgvthdprhgtphhtthhopehlihhn
    uhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfjhhhhh
    iiudelleejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhstggrrhdrrghlfhhonhhs
    ohdrughirgiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PV_raar_gEN8AGqyd5uLVEHKR8s47PGZbANY5Bzv9CN9My_6oI54dw>
    <xmx:PV_raZQHOyFYIMdQlV4zeg_3oek81NqUHVAW1Kh8SL1mig8F-CCH4Q>
    <xmx:PV_raaUB89l3Fl_66fS4DKA4n5d8fR3gIOCEArRQxTFFTiM-ma6S8A>
    <xmx:PV_raef7uNSgGPfAYf_NGZrS5q40MLa68R6AF7jb4I38NTikY8lprQ>
    <xmx:PV_raTDPwFIgzoCkX-gmWuNX4cTuRWV0gH4KFsknqQNrHxhSyBFyk7Dn>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 08:17:01 -0400 (EDT)
Date: Fri, 24 Apr 2026 14:17:00 +0200
From: Greg KH <greg@kroah.com>
To: Brite <brite.airgeddon@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, fjhhz1997@gmail.com,
	oscar.alfonso.diaz@gmail.com
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when
 coexisting with another VIF
Message-ID: <2026042441-destitute-swagger-0ca9@gregkh>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424120807.25005-1-brite.airgeddon@gmail.com>
X-Rspamd-Queue-Id: 6BC9245E49D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35271-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[sipsolutions.net,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]

On Sat, Apr 25, 2026 at 12:08:07AM +1200, Brite wrote:
> Monitor-mode packet injection is broken on drivers that implement
> real channel context ops (mt76 and others) when the
> monitor interface runs alongside another interface (typically AP).
> The monitor VIF never gets a chanctx of its own in this case, so
> ieee80211_monitor_start_xmit() finds vif.bss_conf.chanctx_conf ==
> NULL and takes the fail_rcu path, silently dropping the skb. In
> practice this breaks tooling like mdk4 and aireplay-ng on mt76
> hardware, including airgeddon's evil-twin deauth flow, which runs
> hostapd on an AP VIF and injects deauth frames from a coexisting
> monitor VIF.

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

