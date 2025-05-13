Return-Path: <linux-wireless+bounces-22916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C677BAB57AC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 16:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 261DE7A3F4A
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389B1C07C3;
	Tue, 13 May 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C87jrtDP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E41B4132;
	Tue, 13 May 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148011; cv=none; b=Z2TctkfYhcTXrG44evPdc5dtxUqBC8PdQ2UBRAjPYIOk6wCGC4JUCiOBQY5ssNAbkZP/PKr+D61ALYJeIQcHgPaNAQsNWJ9vo7Wu7c88vSfnGyirjPn0TQs4qwCKv1t28ZUv8qgtM8AzRbbVEuY+uGlvS8DH/nzt2FBQ+SrSpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148011; c=relaxed/simple;
	bh=GvbC2c+OjCD7DQ632XHqVYHW4DAjH5zpIpLAVRh9PIE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABTJjGEJnSEwiz+W7PIDFBmKicaRVhB1Uw7DexKFJpzySgGJ9g8K4E3NBItXaQbLVsbbXfG2PYqJiRzc0mX5fuFF7KF91hojftMrO0fgZaYywPQxP9V1Kf/pBx4N9UWUbBh/CfkwNgTxLCKROoGnl8S5rdF6xbBcRuPk6+qcSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C87jrtDP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=O3s+W4CENWp5WKJKsQ669NJp16U158L6nAfkwICCHoE=;
	t=1747148009; x=1748357609; b=C87jrtDPNMee0kqs1+fkevgzjk5agoTxNax/Y38Jc6TYfQL
	s67l3GpGuAvEKgbWw/1iyRjkpEhHQiNBb5UB8+q/Fee1befMV2KkoTuLQqvDI4PpGaOmIokSwTJ5/
	ORKijNJP3Q1Hn0UCCRnd1APwuRs85+OV97JQZTHdCSkbj6mAsgFY9ZIEqZWjYBMS2RPnHqRH2mCkO
	j0C2QA3/kOqTGpOyYFrGkXds68vrjaPdHv4SKj4+0Qr2iurJSq0iUJfjaSyTTeZcyDEdXo+Q0wTm6
	5TOfZfg9q/nBSMXVfavYdtbq83a1xYCXZxGRT7ipemlNkNYI8oSZzaHJG4im+fSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uEr0X-00000005lK6-3OWu;
	Tue, 13 May 2025 16:53:26 +0200
Message-ID: <eb59751ab2a22adc6237c05cb0a5519657498613.camel@sipsolutions.net>
Subject: Re: wifi: iwlwifi: SAE fails when AP sends confirm before STA
From: Johannes Berg <johannes@sipsolutions.net>
To: Denis Kenzior <denkenz@gmail.com>, Jan Hendrik Farr <kernel@jfarr.cc>
Cc: James Prestwood <prestwoj@gmail.com>, linux-wireless@vger.kernel.org, 
 Miri Korenblit <miriam.rachel.korenblit@intel.com>, iwd@lists.linux.dev
Date: Tue, 13 May 2025 16:53:25 +0200
In-Reply-To: <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
References: <aB30Ea2kRG24LINR@archlinux>
	 <4ffbeb94-ac19-4437-9d98-24981fe6c240@gmail.com>
	 <aB4HC8Iaa6wR5dj7@archlinux>
	 <15943a1f-0e5d-4705-b8ef-3f22fa3fe672@gmail.com>
	 <aB4hMsBfyawYatoj@archlinux>
	 <902daf8802c723d72fff0155cd0638848ce1bc7f.camel@sipsolutions.net>
	 <aB5onavenLymR-QJ@archlinux>
	 <8a1c5172bc0fd9d2a33522294d1a2a4c4ceb313a.camel@sipsolutions.net>
	 <aCMtCCYtNNl4dL5Q@archlinux>
	 <562c4ac5-088d-4bab-9883-1d4f8eca2b2a@gmail.com>
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

On Tue, 2025-05-13 at 09:03 -0500, Denis Kenzior wrote:
> Hi Jan,
>=20
>  >
> > There is a an SAE confirm sent by the AP. It's frame 170 in
> > capture2.pcapng. It's also retried a number of times after that.
> >=20
>=20
> What I also find interesting is that the kernel on the client side report=
s=20
> sending the Authenticate-Confirm 3 times (according to dmesg and trace2.d=
at),=20
> but only a single Confirm from the client is seen in the air trace.  I'm=
=20
> guessing the retransmissions (attempt 2 & 3) are lost somehow?.
>=20
> [64414.164169] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 2/3)
> [64415.063575] iwlwifi 0000:00:14.3: Not associated and the session prote=
ction=20
> is over already...
> [64415.063668] wlan0: Connection to AP 96:2a:6f:b6:d7:9f lost
> [64416.215729] wlan0: send auth to 96:2a:6f:b6:d7:9f (try 3/3)
>=20

I think it's expecting a confirm in response, but that was already lost
before.

johannes

