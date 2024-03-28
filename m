Return-Path: <linux-wireless+bounces-5470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAE889047D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 17:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A17C1F253A1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAC581AC8;
	Thu, 28 Mar 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rvLPM5/2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E38004E
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641931; cv=none; b=FWxWASYkW1iFdZu0VE/8BOSqF5vQx4odrF9yrMF3QXBwAJLierlrWUqdkb7iEBOAIQl/8MWBEfYYYr/hE19Lv7/yM1KIF2aAX9RoVlF3k/o1wkbOCtf7YRbvUfzibEwJrNyT8jWlQHBQADebKC7PUeirFJLFtupxP7FGJJ5VnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641931; c=relaxed/simple;
	bh=+vM1QUNxQli4H70pnNlFpgkwDkoexBt/DTkoyaoyTLk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NDha5QfliKLi4JQg7O+D2ic3+rcqSzpRNS8gqcuuA8H6NjCFOV8UKIKRRUZjoF9aoGr4tLH4cDpmMpRQsQkfeTJqg8lfYdygW0U6MFxvoTeJPmcqSHCvPPXw9TJiwF+oovPrqgOMC7VTM2SFdJ9czOh4Rt1cMpgiCuc1iPB/xgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rvLPM5/2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+vM1QUNxQli4H70pnNlFpgkwDkoexBt/DTkoyaoyTLk=;
	t=1711641929; x=1712851529; b=rvLPM5/2WSsu/acy8dwjdvxAFH3e/o3zrtJSkSS+tmwbDec
	IU3JZYeCWsadDAPNraHzRe8gqswkKm77K1GE17qL71M+h9IXJWNTkPoX31HVrcwhMG4lnDT/yoNYT
	ocerIyzy8SJXteket1OMlI3rmqTkKeqWNJqbQ0DawDgExJQ3mCQjdtk0U0ozvqUq06vAxsqhc2jQ/
	PWN4/lQGzovQtqz1kITGf2jwgs3fCHlaWTCx3hiTHvWUL9CDpLZW2GrkPM3J1a7HMhBSsB3ihQJl0
	AOBDSWNKuXfkYPHA6DDZW/V5OdATNOSrvQyhX072UG88Cr3jXZOQkaVpWBN0k1xA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpsFn-0000000179m-3tJ7;
	Thu, 28 Mar 2024 17:05:24 +0100
Message-ID: <968024261cf1d4e72832451e1c4cc64922d05364.camel@sipsolutions.net>
Subject: Re: No way to cancel SAE after CMD_AUTHENTICATE?
From: Johannes Berg <johannes@sipsolutions.net>
To: James Prestwood <prestwoj@gmail.com>, "open list:MEDIATEK MT76
	WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>
Date: Thu, 28 Mar 2024 17:05:23 +0100
In-Reply-To: <055b857a-83f0-4abb-b6ff-f0eaaf572e64@gmail.com>
References: <055b857a-83f0-4abb-b6ff-f0eaaf572e64@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 08:23 -0700, James Prestwood wrote:
> Hi,
>=20
> I noticed some odd behavior where userspace is unable to cancel an SAE=
=20
> connection until associated. If you issue a CMD_AUTHENTICATE then=20
> immediately (or prior to association) send a CMD_DISCONNECT the kernel=
=20
> will not cancel the authentication and afaict ignore the CMD_DISCONNECT.=
=20
> The kernel will continue to send authenticate events, and even retry=20
> authentication until the retry limit after CMD_DISCONNECT is issued.
>=20
> I see the checks in cfg80211_disconnect which seem to back up this=20
> behavior where its essentially ignored if not "connected". I'm not sure=
=20
> where to actually fix this since the auth retries are internal to=20
> mac80211. Since the device isn't even authenticated I'm unsure what=20
> value/structure to even check in order to detect this situation and=20
> clean up. But there needs to be some way to cancel the authentication,=
=20
> right?

NL80211_CMD_DEAUTHENTICATE should do that? I'm not really surprised you
cannot disconnet when you're not even connected yet, for the most part
the kernel doesn't care about tracking auth state (any more, for many
years now).

johannes

