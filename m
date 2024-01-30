Return-Path: <linux-wireless+bounces-2791-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D589B842120
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855941F23631
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E89627F0;
	Tue, 30 Jan 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Nfq7Zszz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FB60ED9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610100; cv=none; b=qC3dQPZWAjw5EYIObT2etC1AQ46tvqjxc3SUqpkMEzMxcf7KNerfPAsYw0i6V7nP9JT794SCwR9NSJiXSHhv74pIfn8dpsMXywVCFyXDFS6XMyxoYAr7PJWV+e6fvZKYQ5IF736ia9NImATAaX16a4Wb9DJvCdN1YIcEtOSDq/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610100; c=relaxed/simple;
	bh=SUZuQPUjLyJezRMb/heNz1LrRavuHe7d8mQTivid20k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3RcqQHZRzrJnf+PG4Lx3m9K0u0Jrnn6BL3It+2SPveILoUH9vvOB0uzin7+036lofPpn+/mEvSr5l9vhAJMTQFvaSf7xI+8hwL8vgHb4N1VgGYiBGYj0w5XPd2ukHZ+6yMMIIQelXf0I9mXvP9snZWDzH+m6x0NDBoDLQbuYm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Nfq7Zszz; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PPT/OmzLPGq9urvanssuHslmeHqmRcHgPsC0hpe7M48=;
	t=1706610098; x=1707819698; b=Nfq7ZszzCVxke7Kht/FuXJ3tsVvqxD0P6u9St5z2ySN65ir
	VgfnEJnH9BfYtIKOvmIpiF/9vPO0M9pdnsIJcODPN5ey6Y6B35v5sXbyUkCfoXBcGLzDfXJG+gyeM
	LibuHbbfJMow7fqwYhLE6U3ULpoXJ3ESFgaINvemMVNeeaG3YodXQYaaplHtxsSuc7DLMvPrkAfYk
	EsHAxoeR+2pi0moh9OI0kN/FLyQzKxkMpcXvsrKQqsdG5fKALU79+WD9vkm9HNFJ5GqLYwYwaPCjy
	MFHM0HosRZOrx1jK1pz6FSsQkfXY6/qKRq/SDa+HzxhW5iNZ2TxINYIyXQtoDclg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUlFH-00000005yxa-0WMJ;
	Tue, 30 Jan 2024 11:21:35 +0100
Message-ID: <e19c796c9ffe3170e34543c95c6d74ced5b1429f.camel@sipsolutions.net>
Subject: Re: [PATCH v7 5/5] wifi: mac80211: add support to call csa_finish
 on a link
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 11:21:33 +0100
In-Reply-To: <20240130043225.942202-6-quic_adisi@quicinc.com>
References: <20240130043225.942202-1-quic_adisi@quicinc.com>
	 <20240130043225.942202-6-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 10:02 +0530, Aditya Kumar Singh wrote:
> Currently ieee80211_csa_finish() function finalizes CSA by scheduling a
> finalizing worker using the deflink. With MLO, there is a need to do it
> on a given link basis.
>=20
> Add changes to pass link ID of the link on which CSA needs to be finalize=
d.

Why not just directly say

"Pass the link ID of ..."

To me at least it seems obvious that a commit makes changes :)

Anyway .. I'll stop nit-picking too much about your commit messages I
guess, and worst case just rephrase them later.

(I'm kind of working on this area of CSA too right now, though with a
focus on client.)

> +	/* TODO: MBSSID with MLO changes */
>  	if (vif->mbssid_tx_vif =3D=3D vif) {

Could you say (even here) more precisely what'd be needed?

>  		/* Trigger ieee80211_csa_finish() on the non-transmitting
>  		 * interfaces when channel switch is received on
> @@ -3568,7 +3579,7 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif=
)
>  					 &iter->deflink.csa_finalize_work);

that still seems to use deflink there, for sure.

johannes

