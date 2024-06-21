Return-Path: <linux-wireless+bounces-9433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E989125A0
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7119B297B8
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24A15383B;
	Fri, 21 Jun 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LaeiIH7I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72215443A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973426; cv=none; b=chRGz4kX6AX5hEmEmjYdFHcJkKNWYXiI0KP9LHB0zFwAz7theMLHhxCSHzRT7skvgdbz3G9CM2I7I8JFSD3hstH1fYsBeqn8JFkGA/NPDztfv8S0eonjhjiJUDi/LPRcBmFm7b7H3s/3sM/RqS6qIysAgnSN9E5ham+QlTHC9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973426; c=relaxed/simple;
	bh=2StdHxeg1sSAJrmeuKSOzkQwVjwHl88ZoG/POIo1QEA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=geiS7nBwTh9YO6sJbd1VkZoH2nS3o0vHBOHgfWOQ7v+Fc+Ut+XHvnrniM5UJx6ULwVjWveBxTYQArB6VMjDvXtM31eorGVHikfV0Uo6tMDZ7CssMgysj6lcIp5KYsDqaHDlDJ9NnFqOqzLSJtUDHRdoRbr9Y65XOgRquLsaGBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LaeiIH7I; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=si1KA00cBntgKEnHaiKpgkNtVv7kxa20bAztn1WoR6M=;
	t=1718973425; x=1720183025; b=LaeiIH7IqgUgzcZQBobbtyQt2g8YyAWioGJrI0MMxnO8BQi
	XFo4588F7tlGbYE3OAzImRLDO+BUTKK2OOv8xEoFL99T7k3+PATHD8zk8kDLipLO1xqcTJ++w1NDH
	TpBo71Y6MjkNyMeR3IUEVfBhkFbSE6IR28YTPEZbcXxOPxyMuTzDz8bssuWcM4GbbptcePs/kf3+s
	t3IpkO2mlHpmqsNlQWyD4+2Og/Tv+1yGqFGJHc+1OYk4Ck0hgkmY8sutQAvDpG+QiMuy9QjlrssV7
	a6fkHI7NamWeBsM7FmT6bxVgIYbT2v4KXKKu/fR7V2RbeolAiZypcvyGu6i5HKng==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sKdVm-0000000Bt1X-0r8B
	for linux-wireless@vger.kernel.org;
	Fri, 21 Jun 2024 14:37:02 +0200
Message-ID: <9559970ad396591e628424a50b35c5c3dc7b9f63.camel@sipsolutions.net>
Subject: Re: Receive OMI support in mac80211?
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Fri, 21 Jun 2024 14:37:01 +0200
In-Reply-To: <b7ca414c297df4acb0a8132339293ea7249cfad3.camel@sipsolutions.net>
References: 
	<b7ca414c297df4acb0a8132339293ea7249cfad3.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-06-21 at 14:31 +0200, Johannes Berg wrote:
> Hey all,
>=20
> We're contemplating adding some support for using (sending) OMI to save
> power or perhaps other reasons.
>=20
> The implementation logic would seem to end up being somewhat similar to
> some other cases of changing parameters (CSA or simply AP doing
> HT/VHT/HE/EHT operation changes, VHT operating mode notification action
> frame), but=20
>=20
>  - for widening bandwidth/increasing NSS:
>     - update chanctx
>     - send OMI / wait / response
>     - update TX configuration for the STA it was sent to
>=20
>  - for reducing bandwidth/NSS:
>     - update TX configuration for the STA it was sent to
>     - send OMI / wait / response
>     - update chanctx

Hmm. Maybe I sent this too early ;)

Maybe mac80211 shouldn't even do the TX configuration for the STA? It
would have to track this as a separate data point because it's due to
the *local* configuration, so it doesn't actually match the other things
that it's doing today ...

OTOH, if mac80211 does rate control? But maybe we don't really care
about that case? I don't really for iwlwifi ...

And then if we don't care about that part, all we need is to be able to
notify mac80211 about the BW change on that given connection.

johannes

