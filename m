Return-Path: <linux-wireless+bounces-28101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF4BF1A48
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 15:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 216654FBA1B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A32E401;
	Mon, 20 Oct 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wcQpXel+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845701A2545
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967915; cv=none; b=OCKDEBdqVJIGA5nVObtiDcbEpLQFzUecV613GcrV7s57LDtSqOHX4FhhXybA/fzRQZZQkf7jhSQa9mIIuod0UI/qqyeAljdA5YDHHXNXd/4hGQGPbZlPDI7e6PND9Na4eU+JVoX8azUP0PhAO2lnTJ7CWdHL6bT3FBZe7uahess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967915; c=relaxed/simple;
	bh=QQuSgmqSSOFnNqtmC3sSJ12bQoJFN2cO7EteTiBOUTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcC+214kyNNm7X9EOrIVtYakQk+tFaSl1OKQRCNswto2eWj7GhmPhS54Zn7UvHjDVaZBvJe8N+FWM0IKEEA+5Tx4hv5kLuset48iLYh2xisxIxGnLsvGW7PgxDLDn6EBpealwXGLL/snvcDE6RK5wkm2z4ez4PHebXmBfJTyHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wcQpXel+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QQuSgmqSSOFnNqtmC3sSJ12bQoJFN2cO7EteTiBOUTQ=;
	t=1760967913; x=1762177513; b=wcQpXel+ckfjfXQMfvu8LORwnj41dqn1uXhnxoHLK7+jYuL
	8yy1WLY/Bf8JGEnlOkX5NXC/nkd2MdVRPxqKWBCajVZv7V/JiAiFTOy0Fe02y9dM++6yGnXno2Fle
	qh6j3uoNbdS4fXweRRcM4eU4kl0TairR3HeWbsQbOUtexD+KevVGf1JLMUW212j2v8SP5B0FgG/aB
	VEhL4Qh8+FXRq/q7LhbTwMuawTGI3S3lK5PnoO0XFdi1wS6dMDGY73dfH+Mv2Mp6GPEo3v69vkJTm
	VnAWcr1ghGBn1IV8ABDoBtS6VRH6yFxC14KNDJmAxbzR2RKVTef8fUq4uP6yVlOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAqCF-000000091ET-12aI;
	Mon, 20 Oct 2025 15:45:11 +0200
Message-ID: <0f82718459bc6e31238f1189f8f5bfc859b59a3e.camel@sipsolutions.net>
Subject: Re: [PATCH RFC wireless-next] wifi: mac80211_hwsim: dont perform
 rate validation for S1G
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Mon, 20 Oct 2025 15:45:10 +0200
In-Reply-To: <20251008014006.219605-1-lachlan.hodges@morsemicro.com> (sfid-20251008_034024_809179_BC70C823)
References: <20251008014006.219605-1-lachlan.hodges@morsemicro.com>
	 (sfid-20251008_034024_809179_BC70C823)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-10-08 at 12:40 +1100, Lachlan Hodges wrote:
> mac80211 does not support TX/RX rate reporting for S1G bandwidths and
> as a result WARNs occur during validation as the default value of 20MHz
> (0) is always higher then the highest S1G bandwidth of 16MHz. This
> prevents association from occuring in some instances.
>=20
> Skip bandwidth validation for S1G interfaces to avoid spurious WARNs and
> ensure a clean association process as there is no support for S1G TX/RX
> bandwidths.
>=20
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
> This is kind of a bandaid fix (hence why RFC), but implementing proper
> native rate control support for S1G within minstrel and mac80211 is not
> pretty (lack of flag space, ordering of RX bandwidth enum, aliasing with
> VHT flags and a myriad of other issues).

Yeah that makes sense. It might be more feasible with the table-based
approach (sta_rate_tbl_update), but there's not a lot of sense in adding
support for S1G to minstrel (or adding another algorithm) when no driver
would ever use it.

And a lot of the issues would still remain for feedback etc.

> If an S1G driver is submitted it
> would be considered a "modern" driver and would probably contain its own
> rate control. There has been some S1G hostap work recently submitted [1]
> though it's only STA side though this will need to be fixed in order for
> proper tests to be run.

I'm not sure really to be considered "modern" you need driver/firmware
rate control, but I'd assume a new driver were to do that anyway :)

So overall it seems reasonable to mostly ignore the rate control issue,
but maybe it'd make more sense to be "cleaner" about it, maybe
separating out something like HAS_RATE_CONTROL to be per station, i.e.
letting drivers somehow (not) set WLAN_STA_RATE_CONTROL?

And removing the checks here in tx() seems a bit odd, why should that
even be necessary? Surely _something_ would still need to be done here,
even if only to generate some sensible radiotap headers for the virtual
sniffer interface?

johannes

